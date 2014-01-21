module Neutral
  class Voting < ActiveRecord::Base
    before_destroy :delete_votes

    belongs_to :votingable, polymorphic: true

    delegate :votes, to: :votingable

    def difference
      positive - negative
    end

    def self.init(vote)
      create(votingable_type: vote.voteable_type, votingable_id: vote.voteable_id) do |voting|
        voting.increment(vote.nature)
      end
    end

    def add_to_existing(nature)
      increment!(nature)
    end

    def edit(nature)
      increment(nature)
      decrement(nature==:positive ? :negative : :positive)
      save
    end

    def remove(nature)
      decrement!(nature)
    end

    private

    def delete_votes
      votes.delete_all
    end
  end
end
