Dir[Rails.root.join 'app/workers/*.rb'].each { |f| require f }
