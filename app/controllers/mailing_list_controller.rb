class MailingListController < ApplicationController
  
  def join
    email = filter_email(params[:email])
    render :text => 'SMTP injection isn\'t possible... Rails won this battle :('
  end
end