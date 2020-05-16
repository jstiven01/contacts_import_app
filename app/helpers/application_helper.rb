module ApplicationHelper
  def formatting_date(date)
    formatted_date = ''
    begin
      formatted_date = Date.iso8601(date).strftime('%Y %B %e')
    rescue StandardError
      formatted_date = date
    end
    formatted_date
  end
end
