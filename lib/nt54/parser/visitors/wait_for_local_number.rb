module NT54
  class Parser
    module Visitors
      class WaitForLocalNumber < Visitor
        def accept(keypress)
          @number.local_number << keypress
          super
        end
      end
    end
  end
end