class CartController < ApplicationController
  skip_before_filter :protect_from_forgery
  before_filter :get_product, :except => [:show]
  before_filter :make_cart
  
  def show
    p session[:cart]
  end
  
  def add
    item = session[:cart][:items][@product.id]
    session[:cart][:items][@product.id] = item.nil? ? 1 : item+1
    
    redirect_to product_path(session[:session_secret], @product), :notice => "#{@product.name} was added to your cart"
  end
  
  def remove
    session[:cart][:items].delete(@product.id)
    redirect_to cart_path, :notice => "#{@product.name} was removed from your cart"
  end
  
  def update
    qty = (params[:qty] ||= 0).to_i
    
    return remove if qty == 0
    session[:cart][:items][@product.id] = qty if session[:cart][:items][@product.id]

    redirect_to cart_path, :notice => "#{@product.name} was updated in your cart"
  end
  
  private
  def get_product
    @product = Product.find_by_id_and_session_id!(params[:product_id], session[:session_id])
  end
  
  def make_cart
    session[:cart] ||= {:user_id => current_user, :items => {}}
  end
end