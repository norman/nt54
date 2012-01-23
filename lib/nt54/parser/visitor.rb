module NT54
  class Parser
    class Visitor

      attr :number

      def initialize(number)
        NT54.log.debug "new state: #{to_sym}" if NT54.log
        @number = number
      end

      def accept(keypress)
        NT54.log.debug "got #{keypress}" if NT54.log
        return nil
      end

      def to_sym
        self.class.to_s.split("::").last.to_sym
      end
    end
  end
end

require "nt54/parser/visitors/dialtone"
require "nt54/parser/visitors/wait_for_area_code"
require "nt54/parser/visitors/wait_for_area_code_completion"
require "nt54/parser/visitors/wait_for_area_code_or_mobile_prefix_completion"
require "nt54/parser/visitors/wait_for_country_code_end"
require "nt54/parser/visitors/wait_for_country_code_start"
require "nt54/parser/visitors/wait_for_local_number"
require "nt54/parser/visitors/wait_for_local_prefix"
require "nt54/parser/visitors/wait_for_mobile_prefix_completion"
require "nt54/parser/visitors/wait_for_mobile_prefix_or_area_code"
require "nt54/parser/visitors/wait_for_prefix"
require "nt54/parser/visitors/wait_for_special_number_completion"
