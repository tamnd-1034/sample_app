class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t ".follower"
    @users = @user.followers.page(params[:page])
                  .per Settings.paginate.items_per_page
    render "users/show_follow"
  end
end
