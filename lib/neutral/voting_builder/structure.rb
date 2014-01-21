module Neutral
  module VotingBuilder
    class Structure
      def initialize(persisted, difference)
        @persisted = persisted
        @difference = difference
      end

      def to_a
        structure = %w[positive_span positive_link difference_span negative_link negative_span remove_link]
        structure -= %w[remove_link] unless can_change?
        structure -= @difference ? %w[positive_span negative_span] : %w[difference_span]
      end

      private
      def can_change?
        @persisted && Neutral.config.can_change
      end
    end
  end
end
