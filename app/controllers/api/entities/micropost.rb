module API
  module Entities
    class Micropost < Grape::Entity
      expose :id
      expose :content
      expose :user do |micropost|
        API::Entities::User.represent micropost.user, only: %i(id name email)
      end
    end
  end
end
