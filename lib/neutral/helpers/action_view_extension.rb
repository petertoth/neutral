module Neutral
  module Helpers
    module ActionViewExtension
      def voting_for(*args)
        voteable = args.shift
        options = args.extract_options!.merge(voter: current_voter)

        not_voteable(voteable) unless voteable.is_a?(Neutral::Model::ActiveRecordExtension::Voteable)

        Neutral::VotingBuilder::Builder.new(voteable, options).build
      end

      private
      def not_voteable(voteable)
        raise Neutral::Errors::InvalidVoteableObject, "#{voteable.inspect} is not a voteable object. Try adding 'neutral' into your object's model class definition."
      end
    end
  end
end
