module NT54
  class Parser
    module Visitors
      class WaitForCountryCodeEnd < Visitor
        def accept(keypress)
          super
          raise "Expected 4, got #{keypress}" unless keypress.to_s == "4"
          @number.country_code << keypress
          :country_code_completed
        end
      end
    end
  end
end