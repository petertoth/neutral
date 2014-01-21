module VotesControllerBaseClass
  extend ActiveSupport::Concern
  
  included do
    controller do
      rescue_from Neutral::Errors::RequireLogin, with: :require_login
      rescue_from Neutral::Errors::CannotChange, with: :cannot_change
      rescue_from Neutral::Errors::DuplicateVote, with: :duplicate

      def current_voter
        send Neutral.config.current_voter_method
      end

      private
      def require_login
        render 'neutral/votes/errors/require_login', status: 401
      end

      def cannot_change
        render 'neutral/votes/errors/cannot_change', status: 403
      end

      def duplicate
        render 'neutral/votes/errors/duplicate', status: 409
      end
    end
  end
end
