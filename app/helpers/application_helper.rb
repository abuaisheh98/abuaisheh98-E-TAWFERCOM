module ApplicationHelper
  def handle_url(url)
    if url.include? "http"
      link =  url[ url =~ /http/..-1 ]
      link["%3A"] =":/"
      link
    else
      url
    end
  end
end
