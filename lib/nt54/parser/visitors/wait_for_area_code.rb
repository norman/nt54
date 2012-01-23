module NT54
  class Parser
    module Visitors
      class WaitForAreaCode < Visitor
        def accept(keypress)
          super
          @number.area_code << keypress
          if @number.area_code.length == 2 && @number.area
            :area_code_completed
          elsif @number.area_code.length > 2
            :area_code_potentially_completed
          end
        end
      end
    end
  end
end