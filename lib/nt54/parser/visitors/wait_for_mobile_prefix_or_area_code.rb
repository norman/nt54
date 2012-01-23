module NT54
  class Parser
    module Visitors
      class WaitForMobilePrefixOrAreaCode < Visitor
        def accept(keypress)
          super
          case keypress.to_s
          when "1"
            :mobile_prefix_or_area_code_indicated
          when "9"
            @number.mobile = true
            :mobile_prefix_started
          else
            @number.area_code << keypress
            :area_code_started
          end
        end
      end
    end
  end
end