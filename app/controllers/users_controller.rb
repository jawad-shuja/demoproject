class UsersController < ApplicationController
  before_filter :set_user

  def show
    respond_to do |format|
      format.html
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
