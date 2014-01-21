module Neutral
  module Icons
    class Collection
      DEFAULTS = {
        thumbs: {
          positive: 'fa-thumbs-o-up',
          negative: 'fa-thumbs-o-down',
          remove: 'fa-times'
          },
        operations: {
          positive: 'fa-plus-circle',
          negative: 'fa-minus-circle',
          remove: 'fa-times'
        }
      }.freeze

      def initialize
        DEFAULTS.each do |name, definitions|
          define!(name, definitions)
        end
      end

      def add(set)
        already_defined(set.name) if exists? set.name
        define!(set.name, set.definitions)
      end

      private

      class Definitions < Struct.new(:positive, :negative, :remove)
        [:positive=, :negative=, :remove=].each { |method| undef_method method }
      end

      def define!(name, definitions)
        class_eval do
          define_method(name) do
            Definitions.new definitions[:positive], definitions[:negative], definitions[:remove]
          end
        end
      end

      def exists?(name)
        respond_to? name
      end

      def already_defined(name)
        raise Neutral::Errors::AlreadyDefinedIconSet, "Icon set '#{name}' is already defined"
      end

      def method_missing(name)
        raise Neutral::Errors::UndefinedIconSet, "Icon set '#{name}' is not defined"
      end
    end
  end
end
