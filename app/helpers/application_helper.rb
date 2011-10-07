module ApplicationHelper
  def breadcrumbs(page)
    links = []
    
    unless page.nil?
      links << link_to(page.name, page)
      page.ancestors.reverse.each do |p|
        links << link_to(p.name, p)
      end
    end
    
    content_tag :div, :id => 'breadcrumbs' do
      raw(links.reverse.join(' &gt; '))
    end
  end 
  
  def change_session_id
    session[:level] = params[:level].to_i
    case params[:level].to_i
    when 0
      cookies[:session_id] = "SESS-#{request.remote_ip}".chomp
    when 1
      cookies[:session_id] = Base64.encode64("SESS-#{request.remote_ip}").chomp
    when 2
      cookies[:session_id] = "#{ActiveSupport::SecureRandom.hex(2)}#{request.remote_ip}#{Time.now.to_i}"
    else
      cookies[:session_id] = "#{ActiveSupport::SecureRandom.hex(32)}#{Base64.encode64(request.remote_ip).chomp}"
    end
  end 
  
  def decode_msg(str)
    Base64.decode64(str)
  end
end
