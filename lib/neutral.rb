require "neutral/engine"

require "jquery-rails"
require "font-awesome-rails"

require "neutral/engine"
require "neutral/configuration"

module Neutral
  autoload :Engine, 'neutral/engine'
  autoload :Errors, 'neutral/errors'

  module Model
    autoload :ActiveRecordExtension, 'neutral/model/active_record_extension'
    autoload :VoteCached, 'neutral/model/vote_cached'
  end

  module VotingBuilder
    autoload :Builder, 'neutral/voting_builder/builder'
    autoload :Elements, 'neutral/voting_builder/elements'
    autoload :Router, 'neutral/voting_builder/router'
    autoload :Structure, 'neutral/voting_builder/structure'
  end

  module Helpers
    autoload :Routes, 'neutral/helpers/routes'
    autoload :ActionViewExtension, 'neutral/helpers/action_view_extension'
  end

  module Icons
    autoload :Collection, 'neutral/icons/collection'
    autoload :Set, 'neutral/icons/set'
  end

  def self.define(&block)
    module_eval(&block)
  end

  def self.set(name, &block)
    icons.add Icons::Set.new(name, &block)
  end

  def self.icons
    @icons ||= Icons::Collection.new
  end
end
