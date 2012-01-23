module NT54
  class Parser
    module Visitors
      class WaitForAreaCodeCompletion < Visitor
        def accept(keypress)
          super
          # Some area codes overlap, (e.g., 387 and 3873), so we need to check
          # for a 4-digit area code even if we already have a valid 3-digit one.
          candidate = @number.area_code + keypress
          if Area.key? candidate
            NT54.log.debug "#{candidate} is a valid area code" if NT54.log
            @number.area_code = candidate
            :area_code_completed
          elsif Area.key? @number.area_code
            NT54.log.debug "#{@number.area_code} is a valid area code" if NT54.log
            if keypress == "1"
              @number.mobile = true
              :mobile_prefix_started
            else
              @number.local_prefix << keypress
              :area_code_completed
            end
          else
            NT54.log.warn("Continuing with invalid or unknown area code") if NT54.log
            @number.local_prefix << keypress
            :area_code_completed
          end
        end
      end
    end
  end
end