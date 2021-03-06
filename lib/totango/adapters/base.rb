module Totango
  module Adapters
    module Base
      def self.extended(base)
        base.instance_variable_set :@__current_adapter__, Totango::Adapter.new
      end

      private

      def included(klass)
        Totango.adapter = adapter
        klass.send(:include, Totango::Resource) unless klass.include?(Totango::Resource)
        (@defaults || []).each do |e|
          klass.sp_default *e
        end
      end

      def sp_default(k, v)
        @defaults ||= []
        @defaults << [k,v]
      end

      def register_adapter(name)
        adapter.name = name
      end

      def hook_method(name)
        adapter.hook = name
      end

      def action_finder(name)
        adapter.action_finder = name
      end

      def adapter
        @__current_adapter__
      end
    end
  end
end

