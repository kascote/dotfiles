module CNSL
  module RailsLogger

    # Purple messages for Rails logger
    def self.setup
      require 'logger'
      Rails.logger = Logger.new(STDOUT)
      Rails.logger.formatter = proc do |severity, datetime, progname, msg|
        "\033[35m#{msg}\033[0m\n"
      end

      CNSL::Irb.class_eval do
        def sql(query)
          ActiveRecord::Base.connection.select_all(query)
        end
      end

    end
  end
end

CNSL::RailsLogger.setup if defined?(Rails)
