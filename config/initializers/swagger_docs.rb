class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/apidocs",
    :base_path => "https://sales-engine-api.herokuapp.com",
    :clean_directory => true,
    :base_api_controller => ActionController::API,
    :attributes => {
      :info => {
        "title" => "Rails Engine",
        "description" => "Endpoints for record, relationship and business logic for included sales data-set",
        "contact" => "benjaminpjacobs@gmail.com",
        "license" => "MIT",
        "licenseUrl" => "https://opensource.org/licenses/MIT"
      }
    }
  }
})