module API
  module V1
    class Micropost < Grape::API
      include API::V1::Defaults

      helpers do
        def micropost_params
          ActionController::Parameters.new(params[:micropost])
                                      .permit :content, :image
        end
      end

      before do
        authenticate_user!
        @micropost = @current_user.microposts.find params[:id] if params[:id]
      end

      resource :micropost do
        desc "Show all micropost"
        get "", root: :micropost do
          micropost = @current_user.microposts
          micropost_formatted = API::Entities::Micropost.represent micropost, except: [:user]
          response = respond_success micropost: micropost_formatted
          present response
        end

        desc "Create a micropost"
        params do
          requires :micropost, type: Hash do
            requires :content
            requires :image
          end
        end
        post "", root: :micropost do
          micropost = @current_user.microposts.build micropost_params
          micropost.image.attach params[:image]
          micropost.save!
          micropost_formatted = API::Entities::Micropost.represent micropost
          response = respond_success micropost: micropost_formatted
          present response
        end

        desc "Show a micropost"
        get ":id", root: :micropost do
          micropost_formatted = API::Entities::Micropost.represent @micropost
          response = respond_success micropost: micropost_formatted
          present response
        end

        desc "Update a micropost"
        params do
          requires :micropost, type: Hash do
            requires :content
            requires :image
          end
        end
        patch ":id", root: :micropost do
          @micropost.update! micropost_params
          response = respond_success micropost: @micropost
          present response
        end

        desc "Delete a micropost"
        delete ":id", root: :micropost do
          @micropost.destroy
          present respond_success
        end
      end
    end
  end
end
