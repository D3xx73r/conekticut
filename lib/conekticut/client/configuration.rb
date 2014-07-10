module Conekticut
  module Client
    module Configuration
      extend ::ActiveSupport::Concern

      included do
        add_config_option :public_key
        add_config_option :private_key
        add_config_option :conekta_version, "'0.4.4'"
        add_config_option :api_base_path, "'https://api.conekta.io'"
        add_config_option :api_version, "'0.3.0'"
        add_config_option :use_ssl
        add_config_option :ssl_cert_path
      end

      module ClassMethods
        def add_config_option(name, default_value = "nil")
          class_eval <<-RUBY
            def self.#{name}(value=#{default_value})
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
      end # end ClassMethods
    end # end Configuration
  end  # end Client
end # end Conekticut
