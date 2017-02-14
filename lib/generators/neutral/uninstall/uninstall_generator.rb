require File.expand_path('../../formats', __FILE__)

module Neutral
  module Generators
    class UninstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration
      include Neutral::Formats

      source_root File.expand_path("../templates", __FILE__)

      def remove_route
        comment_lines "config/routes.rb", /neutral/
      end

      def remove_locale
        remove_file "config/locales/neutral.yml"
      end

      def remove_stylesheet
        if File.binread(css_format[0]).include? "require neutral"
          gsub_file css_format[0], /#{css_format[1]} require neutral/, ""
        else
          say_status("skipped", "remove from '#{css_format[0]}'", :yellow)
        end
      end

      def remove_database_entities
        if yes?("Remove database entities?('neutral_votes' and 'neutral_votings' tables)")
          migration_template "drop_neutral_votes_table.rb", "db/migrate/drop_neutral_votes_table"
          migration_template "drop_neutral_votings_table.rb", "db/migrate/drop_neutral_votings_table"

          rake("db:migrate")

          Dir.glob("db/migrate/*").keep_if { |f| f.include?("neutral") }.each do |file|
            remove_file(file)
          end if yes?("Remove also remaining migration files?")
        end
      end

      def remove_initializer
        remove_file "config/initializers/neutral.rb"
      end

      private
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end
