module DateSearch
  extend ActiveSupport::Concern

  def date_search
    search = {}
    search[:created_at] = params["created_at"].to_datetime if params["created_at"]
    search[:updated_at] = params["updated_at"].to_datetime if params["updated_at"]
    return search
  end
  
end