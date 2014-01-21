module Neutral
  module Icons
    class Set
      attr_reader :definitions
      def initialize(name, &block)
        @name = name
        @definitions = Neutral.icons.send(Neutral.config.default_icon_set).to_h
        instance_eval(&block) if block_given?
      end

      def name
        @name.to_sym
      end

      [:positive, :negative, :remove].each do |icon|
        define_method(icon) do |definition|
          definitions[icon] = definition.to_s
        end
      end
    end
  end
end
