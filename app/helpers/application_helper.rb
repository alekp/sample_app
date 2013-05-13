module ApplicationHelper
  
  # Return per-page application wide page title
  def title
    base_title = "Ruby On Rails Tutorial Sample App"
    if @title.nil?
    base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
