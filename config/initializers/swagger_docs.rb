Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_file_path => "public/apidocs",
    :base_path => "http://localhost:3000",
    :clean_directory => true,
    :base_api_controller => ActionController::API,
    :attributes => {
      :info => {
        "title" => "Rails Engine",
        "description" => "Test",
        "contact" => "benjaminpjacobs@gmail.com",
        # "license" => "MIT",
        # "licenseUrl" => "https://opensource.org/licenses/MIT"
      }
    }
  }
})