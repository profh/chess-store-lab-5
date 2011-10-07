module Levels
  module Low
    def login(session_id, username, password)
      User.find_by_sql("SELECT * FROM users WHERE session_id = '#{session_id}' AND username = '#{username}' AND password = '#{password}' LIMIT 1").first
    end
    
    # removes double quotes (") for sanitization
    def sanitize(review)
      xss_filter(review)
    end
    
    # don't filter filenames for file inclusion
    def filter_filename(filename)
      filename
    end
    
    def filter_search(search)
      xss_filter(search)
    end
    
    def filter_email(email)
      email.gsub(/\;(.*)/, '')
    end
    
    def user_sanitize(search)
      recursive_remove(search, /(<script.*?>)|(<\/script>)|(javascript)|(\")/i).gsub(/;/,'')
    end
    
    private
    def xss_filter(text)
      text.gsub(/\"/, '')
    end
    
    def recursive_remove(original_str, regex)
      until clean ||= false
        original_str = original_str.gsub(regex, '')
        clean = original_str.match(regex).nil?
      end
      
      original_str
    end
  end
end