module Neutral
  module VotingBuilder
    class Router
      include Neutral::Engine.routes.url_helpers

      def initialize(vote)
        @vote = vote
      end

      def [](element)
        send element
      end

      def positive
        if persisted?
          { path: vote_path(vote, value: 1), method: 'patch' }
        else
          { path: votes_path(vote: vote.main_attributes.merge(value: 1)), method: 'post' }
        end
      end

      def negative
        if persisted?
          { path: vote_path(vote, value: 0), method: 'patch' }
        else
          { path: votes_path(vote: vote.main_attributes.merge(value: 0)), method: 'post' }
        end
      end

      def remove
        raise "Remove path for non-existent vote cannot be obtained" unless persisted?
        { path: vote_path(vote), method: 'delete' }
      end

      private
      def vote
        @vote
      end

      def persisted?
        vote.persisted?
      end
    end
  end
end
