# frozen_string_literal: true

module Rubytoolbox
  class Api
    #
    # A simple base class for data wrapper objects / structs. Libraries like
    # dry-struct are normally very handy for these things but to keep dependencies
    # minimal we roll our own simple utility here.
    #
    # Usage:
    #
    #   class Foo < Rubytoolbox::Api::ResponseWrapper
    #     field :foo
    #     field :bar, &:reverse
    #   end
    #
    #  Foo.new(foo: "foo", bar: "bar").bar # => "rab"
    #
    class ResponseWrapper
      class << self
        def field(name, &block)
          fields << name.to_s

          block ||= ->(value) { value }

          define_method "#{name}=" do |value|
            instance_variable_set "@#{name}", block.call(value)
          end

          attr_reader name
          private "#{name}="
        end

        def fields
          @fields ||= []
        end
      end

      def initialize(data)
        self.class.fields.each do |name|
          value = data.key?(name.to_s) ? data[name.to_s] : data[name.to_sym]

          send "#{name}=", value unless value.nil?
        end
      end
    end
  end
end
