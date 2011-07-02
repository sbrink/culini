namespace :carts do

    desc "Cleans up old carts"
    task :cleanup => :environment do
      Cart.stalled.delete_all
      puts "Cleaned up old carts"
    end

end
