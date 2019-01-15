# frozen_string_literal: true

module Bundler
  def self.setup
    Paperback::Environment.activate(output: $stderr)
  end

  def self.require(*groups)
    Paperback::Environment.require_groups(*groups)
  end

  def self.default_lockfile
    Pathname.new(Paperback::Environment.lockfile_name)
  end

  module Rubygems
    def self.loaded_specs(gem_name)
      Gem::Specification.new(Paperback::Environment.activated_gems[gem_name])
    end
  end

  # This is only emulated for bin/spring: we really don't want to try to
  # actually reproduce Bundler's API
  class LockfileParser
    def initialize(content)
    end

    def specs
      []
    end
  end

  def self.rubygems
    Rubygems
  end

  def self.with_original_env
    # TODO
    yield
  end

  def self.with_clean_env
    # TODO
    yield
  end

  def self.settings
    if gemfile = Paperback::Environment.gemfile
      { "gemfile" => gemfile.filename }
    else
      {}
    end
  end
end
