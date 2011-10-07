module Levels
  module High
    def login(session_id, username, password)
      account = User.find_by_sql("SELECT * FROM users WHERE session_id = '#{session_id}' AND username = '#{username}' AND password = '#{password}' LIMIT 1").first      
      # account = Account.find_by_session_id_and_username_and_password(session_id, username, password)
      sleep(3) if account.nil?
      
      account
    end
    
    # recursively remove all </?script> tags, then also remove ;
    def sanitize(review)
      recursive_remove(review, /(<script.*?>)|(<\/script>)/i).gsub(/;/,'')      
    end
    
    # recursively remove ../ to "prevent" path traversal, then remove etc/passwd or mdb :)
    def filter_filename(filename)
      recursive_remove(filename, /\.\.\//).gsub(/(etc\/passwd|mdb)/,'')
    end
    
    def filter_search(search)
      recursive_remove(search, /(<script.*?>)|(<\/script>)|(\")/i).gsub(/;/,'')
    end
    
    def user_sanitize(search)
      recursive_remove(search, /(<script.*?>)|(<\/script>)|(javascript)|(\")/i).gsub(/;/,'')
    end
    
    private
    def recursive_remove(original_str, regex)
      until clean ||= false
        original_str = original_str.gsub(regex, '')
        clean = original_str.match(regex).nil?
      end
      
      original_str
    end
  end
end