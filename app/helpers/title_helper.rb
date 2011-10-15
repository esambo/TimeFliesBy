module TitleHelper
  def title(page_title = nil, show_title = true)
   @show_title = show_title 
   @content_for_title = page_title
  end

  def show_title?
    @show_title
  end

  def get_title
    @content_for_title ||= "#{controller.controller_name.titleize} #{controller.action_name.titleize}"
  end
end
