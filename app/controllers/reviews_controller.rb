class ReviewsController < ApplicationController
  def create
    @product = Product.find_by_id_and_session_id!(params[:product_id], session[:session_id])
    @review = Review.new(params[:review])
    @review.session_id = session[:session_id]
    @review.product_id = @product.id
    @review.user_id = current_user.nil? ? nil : current_user.id
    @review.review = sanitize(@review.review)
    
    if @review.save
      redirect_to product_path(session[:session_secret], @product), :notice => 'Your review was posted'
    else
      flash.now[:alert] = @review.errors.full_messages
      render :action => 'products/show'
    end
  end
end