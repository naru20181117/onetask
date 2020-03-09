class Application < Rails::Application
    config.generators do |g|
        g.template_engine :slim
        g.test_framework :false
    end
end
