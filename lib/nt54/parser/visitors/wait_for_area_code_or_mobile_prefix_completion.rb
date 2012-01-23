module NT54
  class Parser
    module Visitors
      class WaitForAreaCodeOrMobilePrefixCompletion < Visitor
        def accept(keypress)
          super
          if keypress == "1"
            @number.area_code = "11"
            :area_code_completed
          elsif keypress == "5"
            @number.mobile = true
            :mobile_prefix_completed
          elsif keypress == "0" || keypress == "2"
            @number.special_sequence = "1#{keypress}"
            :special_number_started
          else raise "Invalid number #{keypress}"
          end
        end
      end
    end
  end
end

