module Neutral
  module Helpers
    module CurrentVoter
      extend ActiveSupport::Concern

      def current_voter
        send Neutral.config.current_voter_method
      end

      included do
        helper_method :current_voter
      end
    end
  end
end
