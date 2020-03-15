class Application < Rails::Application
  config.generators do |g|
    g.template_engine :slim
    g.test_framework :rspec,
                      fixtures: true,
                      view_specs: false,
                      helper_specs: false,
                      routing_specs: false,
                      controller_specs: true,
                      request_specs: false
    g.fixture_replacement :factory_bot, dir: "spec/factories"
  end
end
