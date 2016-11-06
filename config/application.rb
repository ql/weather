require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weather
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/services)

    config.browserify_rails.commandline_options = "-t [ babelify --presets [ es2015 react ] ]"


    unless Rails.env.production?
        config.browserify_rails.paths << lambda { |p|
            p.start_with?(Rails.root.join("spec/javascripts").to_s)
        }
    end
  end
end

require 'trailblazer/rails/railtie'

