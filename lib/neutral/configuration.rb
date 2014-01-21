module Neutral
  def self.config
    @config ||= Configuration.new
  end

  def self.configure(&block)
    yield config if block_given?
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :can_change
    config_accessor :current_voter_method
    config_accessor :require_login
    config_accessor :vote_owner_class
    config_accessor :default_icon_set
  end

  configure do |config|
    config.can_change = true
    config.current_voter_method = :current_user
    config.require_login = true
    config.vote_owner_class = 'User'
    config.default_icon_set = :thumbs
  end
end
