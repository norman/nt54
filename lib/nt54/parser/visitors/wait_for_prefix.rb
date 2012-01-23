module NT54
  class Parser
    module Visitors
      class WaitForPrefix < Visitor
        def accept(keypress)
          super
          if keypress == "1"
            @number.mobile = true
            :mobile_prefix_started
          else
            @number.local_prefix << keypress
            :local_prefix_started
          end
        end
      end
    end
  end
end