class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @users = User.all
  end

  def components
  end


  def account
    @user = current_user
  end

  def my_businesses
    @businesses = Business.where(user_id: current_user)
  end

end
