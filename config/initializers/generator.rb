class Application < Rails::Application
    config.generators do |g|
        # g.template_engine :erb
        g.test_framework :false
    end
end
