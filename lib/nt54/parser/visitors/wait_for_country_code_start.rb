module NT54
  class Parser
    module Visitors
      class WaitForCountryCodeStart < Visitor
        def accept(keypress)
          super
          raise "Expected 5, got #{keypress}" unless keypress.to_s == "5"
          @number.country_code << keypress
          :country_code_started
        end
      end
    end
  end
end