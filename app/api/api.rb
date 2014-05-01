module API
  class Root < Grape::API

    helpers do
      def authenticate! access_token
        error!('401 Unauthorized', 401) unless AccessToken.find_by(:token => access_token)
      end
    end
  
    mount API::BooksV1
    mount API::BookInstancesV1
    mount API::UsersV1
    mount API::LoansV1

    if Rails.env.development?
      add_swagger_documentation :base_path => "http://localhost:3000/api", 
                                :markdown => true, 
                                :hide_documentation_path => true
    else
      add_swagger_documentation :base_path => "http://booklibraryapi.herokuapp.com/api", 
                                :markdown => true, 
                                :hide_documentation_path => true
    end
  end
end