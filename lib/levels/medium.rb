module Levels
  module Medium
    def login(session_id, username, password)
      username, password = "'#{username}'", "'#{password}'"
      Account.find_by_sql("SELECT * FROM accounts WHERE session_id = '#{session_id}' AND username = #{username} AND password = #{password}").first
    end
    
    # remove all occurrences of </?script>
    def sanitize(review)
      xss_filter(review)
    end
    
    # remove ../ to "prevent" path traversal :)
    def filter_filename(filename)
      filename.gsub(/(\.\.\/)/, '')
    end
    
    def filter_search(search)
      xss_filter(search)
    end
    
    def filter_email(email)
      email.gsub(/\;(.*)/)
    end
    
    def user_sanitize(search)
      recursive_remove(search, /(<script.*?>)|(<\/script>)|(javascript)|(\")/i).gsub(/;/,'')
    end
    
    private
    def xss_filter(text)
      text.gsub(/(<script.*?>)|(<\/script>)|(\")/i, '')
      #text.gsub(/(<script.*?>)|(<\/script>)|(\")/, '')
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