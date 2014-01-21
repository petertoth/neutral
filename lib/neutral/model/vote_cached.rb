module Neutral
  module Model
    module VoteCached
      extend ActiveSupport::Concern

      included do
        delegate :voting, to: :voteable

        after_create :add_vote_to_voting
        after_update :edit_vote_within_voting
        after_destroy :remove_vote_from_voting
      end

      def add_vote_to_voting
        if voting
          voting.add_to_existing(nature)
        else
          Voting.init(self)
          clear_association_cache
        end
      end

      def edit_vote_within_voting
        voting.edit nature
      end

      def remove_vote_from_voting
        voting.remove nature
      end
    end
  end
end
