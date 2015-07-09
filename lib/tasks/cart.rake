namespace :cart do
  desc "Rake task to clear expired cart"
  task :clear => :environment do
    cart_time = Time.now - 600
    expired_cart = Cart.where("updated_at < ?", cart_time).where(expired: false)
    expired_cart.destroy_all
    puts "#{Time.now} - Success!"
  end
end
