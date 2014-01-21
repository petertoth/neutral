module Neutral
  module Errors
    class InvalidVoteableObject < StandardError;end
    class RequireLogin < StandardError;end
    class InvalidVoterInstance < StandardError;end
    class CannotChange < StandardError;end
    class DuplicateVote < StandardError;end
    class UndefinedIconSet < StandardError;end
    class AlreadyDefinedIconSet < StandardError;end
  end
end
