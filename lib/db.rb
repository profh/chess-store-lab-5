include ActiveSupport::SecureRandom

class DB
  class << self
    def populate(session_id)
      create_users(session_id)
      create_categories(session_id)
      create_products(session_id)
    end
  
    def empty(session_id)
      ActiveRecord::Base.connection.tables.each do |table|
        unless table == 'schema_migrations'
          ActiveRecord::Base.connection.execute("DELETE FROM #{table} WHERE session_id = '#{session_id}';")
        end
      end
      
      ActiveRecord::Base.connection.execute("VACUUM;")
    end
  
    def reset(session_id)
      empty(session_id)
      populate(session_id)
    end
  
    private
    def create_categories(session_id)
      @chess_sets = Category.new(:name => 'Chess Sets', :code => 'CS')
        @chess_sets.session_id = session_id
        @chess_sets.save!
      @chess_boards = Category.new(:name => 'Chess Boards', :code => 'CB')
        @chess_boards.session_id = session_id
        @chess_boards.save!
      @tournament_kits = Category.new(:name => 'Tournament Kits', :code => 'TK')
        @tournament_kits.session_id = session_id
        @tournament_kits.save!
      @storage_kits = Category.new(:name => 'Storage Kits', :code => 'SK')
        @storage_kits.session_id = session_id
        @storage_kits.save!
    end
  
    def create_products(session_id)
      categories = {}
      categories[:chess_sets] = ['German Staunton', 'French Lardy', 'German Knight', 'Royal Guard', 'British Staunton', 'Deluxe Old Club', 'Yugoslavia Staunton', 'Fierce Knight', 'Parker Staunton', 'Sheesham', 'Ebonized Boxwood', 'Rosewood']
      categories[:chess_boards] = ['Bud Rosewood', 'Ebony & Maple', 'Striped Ebony', 'Mahogany', 'Black Walnut', 'Teak & Maple', 'Wengue', 'Maccassar', 'Elm', 'Palisander', 'Blue Ash', 'Red & Black', 'Green & Erable', 'Gray & Erable', 'Brown Ash Burl', 'Black & Ash']
      categories[:tournament_kits] = ['Value Club Pieces', 'ClubTourney Black', 'Value Club Kit']
      categories[:storage_kits] = ['Mahogany Chess Box', 'Ebony Chess Box', 'Walnut Chess Box', 'Rosewood Chess Box', 'Green Chess Bag', 'Red Chess Bag', 'Blue Chess Bag', 'Walnut Folding Case', 'Macassar Ebony Case', 'Elm Root Case', 'Madrona Root Case', 'Alabaster & Wood Case']
            
      categories.each do |category, products|
        products.each do |product|
          current_product = Product.new(:upc => rand(9999999999), :name => product, :image => product.parameterize, :description => 'Descriptions will come later', :price => rand(99)+rand(9)+(rand(100)/100.0), :is_active => true)
            current_product.session_id = session_id
            current_product.save!
          current_product.categories << eval("@#{category.to_s}")
        end
      end
    end
  
    def create_users(session_id)
      # create the initial user - this is the user that should be hacked
      user = User.new(username:'admin', password:'admin', first_name:'Store', last_name:'Owner', race:'african', registration_key:SecureRandom.hex(25), is_admin:true, is_active:true)
      user.session_id = session_id
      user.save!
      
      # user to find with brute force
      user = User.new(username:'mheimann', password:'ilovegod', first_name:'Mark', last_name:'Heimann', race:'asian', registration_key:SecureRandom.hex(25), is_admin:false, is_active:true)
      user.session_id = session_id
      user.save!
      # add an bogus order for Mark
      order = Order.new(sub_total:34.86, tax: 2.09, total: 36.95, billing_address_id: 1, shipping_address_id: 1)
      order.session_id = session_id
      order.user_id = user.id

      
      # another user for for potential brute force
      user = User.new(username:'lheimann', password:'captain', first_name:'Hack me?', last_name:'You are in trouble!', race:'white', registration_key:SecureRandom.hex(25), is_admin:false, is_active:true)
      user.session_id = session_id
      user.save!
      
      # another user for for potential brute force
      user = User.new(username:'gruberman', password:'leep', first_name:'Ed', last_name:'Gruberman', race:'white', registration_key:SecureRandom.hex(25), is_admin:false, is_active:true)
      user.session_id = session_id
      user.save!
    
      10.times do
        u = User.new
        u.session_id = session_id
        u.username = Faker::Internet.user_name
        u.password = '1q2w3e'
        u.first_name = Faker::Name.first_name
        u.last_name = Faker::Name.last_name
        u.last_name = "asian"
        u.registration_key = SecureRandom.hex(25)
        u.is_admin = false
        u.is_active = true
        u.save
      end
    end
  end
end