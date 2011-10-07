class StaticsController < ApplicationController
  def show
    @page = filter_filename(params[:page])
    
    begin
      render :file => File.join(Rails.root, 'includes', @page)
    rescue
      render :action => 'not_found'
    end
  end
end
