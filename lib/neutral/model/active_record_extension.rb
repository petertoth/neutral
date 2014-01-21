module Neutral
  module Model
    module ActiveRecordExtension
      def neutral
        include Voteable
      end

      def neutral_voter
        include Voter
      end

      module Voteable
        extend ActiveSupport::Concern

        included do
          has_many :votes, as: :voteable, class_name: Neutral::Vote, dependent: :destroy
          has_one :voting, as: :votingable, class_name: Neutral::Voting, dependent: :destroy
          has_many :voters, through: :votes, source: :voter
        end
      end

      module Voter
        extend ActiveSupport::Concern

        included do
          has_many :votes_given, class_name: Neutral::Vote, foreign_key: :voter_id
        end
      end
    end
  end
end
