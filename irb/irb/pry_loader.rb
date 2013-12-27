module CNSL
  module Pry
    def self.setup
      return unless CNSL.try_require 'pry'

      load_pry_plugins

      ::Pry.prompt = [proc { |obj, nest_level| "#{self.pwd} (#{obj}) > " },
                      proc { |obj, nest_level| "#{self.pwd} (#{obj}) * " }]
      @@home = Dir.home

      TopLevel.new.pry
      exit
    end

    def self.load_pry_plugins
      CNSL.try_require 'pry-doc'
      CNSL.try_require 'pry-rails' if defined?(Rails)
      CNSL.try_require 'pry-debugger'
      CNSL.try_require 'pry-stack_explorer'
    end

    def self.pwd
      Dir.pwd.gsub(/^#{@@home}/, '~')
    end
  end

  class TopLevel
    def to_s
      defined?(Rails) ? Rails.env : "main"
    end
    Object.__send__(:include, Rails::ConsoleMethods) if defined?(Rails::ConsoleMethods)
  end
end

CNSL::Pry.setup

