require 'neutral/voting_builder/elements/link'
require 'neutral/voting_builder/elements/span'

module Neutral
  module VotingBuilder
    module Elements
      private

      %w[positive negative difference].each do |span|
        define_method("#{span}_span") do
          Span.const_get(span.capitalize).new voting.send(span)
        end
      end


      %w[positive negative remove].each do |link|
        define_method("#{link}_link") do
          Link.const_get(link.capitalize).new router[link], Neutral.icons.send(icons).send(link)
        end
      end
    end
  end
end
