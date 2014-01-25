require_dependency 'application_controller'

module Neutral
  class VotesController < ApplicationController
    layout false

    before_filter :require_login?, only: :create
    before_filter :can_change?, except: :create

    def create
      @vote = Vote.create(vote_params)
    end

    def update
      vote.update_attributes(value: params[:value])
    end

    def destroy
      vote.destroy
    end

    helper_method :vote, :voting
    def vote
      @vote ||= Vote.find_by(id: params[:id]) || Vote.new(vote_params)
    end

    def voting
      @voting ||= vote.voting || Voting.new
    end

    private
    def require_login?
      raise Errors::RequireLogin if Neutral.config.require_login && !current_voter
    end

    def can_change?
      raise Errors::CannotChange unless Neutral.config.can_change && owner?
    end

    def vote_params
      params.require(:vote).permit(:voteable_type, :voteable_id, :value).merge voter_id: current_voter.try(:id)
    end

    def owner?
      current_voter == vote.voter
    end
  end
end
