class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      respond_to :js
    else
      flash[:danger] = t ".can_not_find_user"
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if @user
      current_user.unfollow @user
      respond_to :js
    else
      flash[:danger] = t ".can_not_find_user"
    end
  end
end
