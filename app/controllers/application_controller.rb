class ApplicationController < ActionController::API
  def not_found
    render :json => { :error => 'Not Found', :documentation => "https://sales-engine-api.herokuapp.com/apidocs/index.html" }, :status => 404
  end
end
