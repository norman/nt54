module NT54
  class Parser
    module Visitors
      class WaitForLocalPrefix < Visitor
        def accept(keypress)
          super
          combo = [@number.area_code.length, @number.local_prefix.length]
          if combo == [2,4] || combo == [3,3] || combo == [4,2] || combo == [0, 4]
            @number.local_number << keypress
            return :local_prefix_completed
          else
            @number.local_prefix << keypress
            nil
          end
        end
      end
    end
  end
end