module Neutral
  module VotesHelper
    def by_url
      return raw "a[href*='#{request.post? ? votes_path : vote_path}']"
    end

    def vote_path(value=[1,0].sample)
      raw neutral.vote_path(vote, value: value)
    end

    def votes_path(value=[1,0].sample)
      raw neutral.votes_path(vote: vote.main_attributes.update(value: value))
    end
  end
end
