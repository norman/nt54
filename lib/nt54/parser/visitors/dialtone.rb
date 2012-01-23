module NT54
  class Parser
    module Visitors
      class Dialtone < Visitor
        def accept(keypress)
          super
          case keypress
          when "+"
            :country_code_indicated
          when "1"
            :mobile_prefix_or_area_code_started
          when "0"
            :area_code_indicated
          when ("4".."8")
            @number.local_prefix << keypress
            :local_prefix_started
          when("9")
            @number.special_sequence << keypress
            :special_number_started
          else raise "Don't know how to handle #{keypress}"
          end
        end
      end
    end
  end
end