module ApplicationHelper
  def title(page_title = nil, show_title = true)
    @show_title = show_title
    if page_title.nil?
      @content_for_title
    elsif page_title.blank?
      @content_for_title = "#{controller.controller_name.titleize} #{controller.action_name.titleize}"
    else
      @content_for_title = page_title.to_s
    end
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
