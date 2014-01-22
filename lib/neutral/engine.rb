module Neutral
  class Engine < ::Rails::Engine
    isolate_namespace Neutral

    initializer 'extensions' do
      ::ActiveSupport.on_load(:active_record) { extend Neutral::Model::ActiveRecordExtension }
      ::ActiveSupport.on_load(:action_view) { include Neutral::Helpers::ActionViewExtension }
      ::ActionDispatch::Routing::Mapper.send(:include, Neutral::Helpers::Routes)
      ::ApplicationController.send(:include, Neutral::Helpers::CurrentVoter)
    end

    config.after_initialize do
      require 'neutral/application_controller'
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets = false
      g.helpers = false
    end
  end
end

