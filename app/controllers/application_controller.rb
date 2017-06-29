class ApplicationController < ActionController::API
  def not_found
    render :json => { :error => 'Not Found' }, :status => 404
  end
end
