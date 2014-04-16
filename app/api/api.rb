module API
  class Root < Grape::API

    # helpers do
    #   def authenticate! access_token
    #     error!('401 Unauthorized', 401) unless AccessToken.find_by(:token => access_token)
    #   end
    # end
  
    mount API::BooksV1
    mount API::BookInstancesV1

    add_swagger_documentation :base_path => "http://booklibraryapi.herokuapp.com/api", 
                              :markdown => true, 
                              :hide_documentation_path => true
  end
end