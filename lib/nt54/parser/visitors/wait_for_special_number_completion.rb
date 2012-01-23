module NT54
  class Parser
    module Visitors
      class WaitForSpecialNumberCompletion < Visitor
        def accept(keypress)
          @number.special_sequence << keypress
          super
        end
      end
    end
  end
end