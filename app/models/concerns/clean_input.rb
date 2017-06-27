module CleanInput
  extend ActiveSupport::Concern

  def self.for_sql(str)
    str.gsub(/([^\w\s])/, '')
  end
end
