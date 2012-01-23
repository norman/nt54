module NT54
  class Parser
    module Visitors
      class WaitForMobilePrefixCompletion < Visitor
        def accept(keypress)
          super
          raise "Expected 5, got #{keypress}" unless keypress.to_s == "5"
          :mobile_prefix_completed
        end
      end
    end
  end
end