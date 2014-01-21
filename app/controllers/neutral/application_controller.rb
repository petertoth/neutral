module Neutral
  class ApplicationController < ::ApplicationController
    protect_from_forgery

    rescue_from Errors::RequireLogin, with: :require_login
    rescue_from Errors::CannotChange, with: :cannot_change
    rescue_from Errors::DuplicateVote, with: :duplicate

    private
    def require_login
      render 'neutral/votes/errors/require_login'
    end

    def cannot_change
      render 'neutral/votes/errors/cannot_change'
    end

    def duplicate
      render 'neutral/votes/errors/duplicate'
    end
  end
end
