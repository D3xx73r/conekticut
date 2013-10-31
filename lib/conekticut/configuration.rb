module Conekticut
  module Configuration
    extend ::ActiveSupport::Concern

    included do
      # Client configuration
      add_config_option :public_key
      add_config_option :private_key
      add_config_option :api_base_path

      # Resource configuration
      add_config_option :currency
      add_config_option :amount
      add_config_option :description
      add_config_option :reference_id
      add_config_option :card
      add_config_option :number
      add_config_option :name
      add_config_option :exp_month
      add_config_option :exp_year
      add_config_option :cvc
      add_config_option :address
      add_config_option :street1
      add_config_option :city
      add_config_option :state
      add_config_option :country
      add_config_option :zip
    end

    module ClassMethods
      def add_config_option(name, default_value = nil)
        class_eval <<-RUBY
          def self.#{name}(value=nil)
            @#{name} = value if value
            return @#{name} if self.object_id == #{self.object_id} || defined?(@#{name})
            name = superclass.#{name}
            return nil if name.nil? && !instance_variable_defined?("@#{name}")
            @#{name} = name && !name.is_a?(Module) && !name.is_a?(Symbol) && !name.is_a?(Numeric) && !name.is_a?(TrueClass) && !name.is_a?(FalseClass) ? name.dup : name
          end

          def self.#{name}=(value)
            @#{name} = value
          end

          def #{name}=(value)
            @#{name} = value
          end

          def #{name}
            value = @#{name} if instance_variable_defined?(:@#{name})
            value = self.class.#{name} unless instance_variable_defined?(:@#{name})
            if value.instance_of?(Proc)
              value.arity >= 1 ? value.call(self) : value.call
            else
              value
            end
          end
        RUBY
      end

      def configure
        yield self
      end

      def configure_resource
        yield self
      end
    end # end ClassMethods
  end # end Configuration
end # end Conekticut
