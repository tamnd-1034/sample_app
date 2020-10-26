module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      resource :users do
        desc "Return all users"
        get "", root: :users do
          users = User.includes(:microposts)
          users_formatted = API::Entities::User.represent users, except: [:microposts]
          response = respond_success users: users_formatted
          present response
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: :user do
          user = User.find params[:id]
          user_formatted = API::Entities::User.represent user, only: %i(name email microposts)
          response = respond_success user: user_formatted
          present response
        end
      end
    end
  end
end
