class StoreController < ApplicationController
  def index
    
    @featured_product = Product.where(:session_id => session[:session_id]).order(Time.new).first
    @products = Product.where(:session_id => session[:session_id]).order('RANDOM()').limit(12)
  end
end
