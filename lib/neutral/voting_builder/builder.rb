module Neutral
  module VotingBuilder
    class Builder
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::OutputSafetyHelper
      include Elements

      attr_reader :voteable, :voter, :icons, :difference
      def initialize(voteable, options)
        @voteable = voteable
        @voter = options[:voter]
        @icons = options[:icons] || Neutral.config.default_icon_set
        @difference = options[:difference]
      end

      def build
        content_tag :div, elements, class: 'neutral'
      end

      private
      def elements
        safe_join(structure.map { |element| send(element) })
      end

      def voting
        voteable.voting || Neutral::Voting.new
      end

      def vote
        @vote ||= voter && voteable.votes.where(voter_id: voter.id).first_or_initialize || voteable.votes.new
      end

      def router
        @router ||= Router.new vote
      end

      def structure
        Structure.new(vote.persisted?, difference).to_a
      end
    end
  end
end
