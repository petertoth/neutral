module Neutral
  class Vote < ActiveRecord::Base
    before_update :avoid_duplication

    validates_inclusion_of :value, in: [0,1]
    validates_presence_of :voteable_type, :voteable_id, :value

    belongs_to :voteable, polymorphic: true
    belongs_to :voter, class_name: Neutral.config.vote_owner_class.classify

    include Neutral::Model::VoteCached

    def nature
      value == 1 ? :positive : :negative
    end

    def main_attributes
      attributes.symbolize_keys.except(:id, :voter_id, :created_at, :updated_at)
    end

    private
    def avoid_duplication
      raise Errors::DuplicateVote unless self.changed?
    end
  end
end
