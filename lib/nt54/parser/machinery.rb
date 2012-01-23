module NT54
  class Parser

    module Machinery
      private

      def self.included(base)
        base.extend ClassMethods
      end

      def machine
        @machine or begin
          @machine = MicroMachine.new(:Dialtone).tap do |m|
            m.instance_variable_set :@transitions_for, self.class.transitions
          end
        end
      end

      def respond_to(event)
        return if event.nil?
        next_visitor = machine.transitions_for[event][machine.state]
        send event
        @visitor = Visitors.const_get(next_visitor).new(@number)
      end

      module ClassMethods
        def trigger(name, &block)
          triggers << name
          transitions[name] = {}
          class_eval(<<-END, __FILE__, __LINE__ + 1)
            def #{name}
              NT54.log.debug "triggering #{name}" if NT54.log
              machine.trigger :#{name}
            end
          END
        end

        def transition(from, to)
          transitions[triggers.last][from] = to
        end

        def transitions
          @transitions ||= {}
        end

        def triggers
          @triggers ||= []
        end
      end
    end
  end
end