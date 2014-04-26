class UsersV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  resource :users do

    desc "Return a User"
    params do
      requires :email, type: Integer, desc: "User email address."
    end
    get ':email' do
      authenticate! params[:access_token]
      User.find_by_email(params[:email]) || error!("Not Found", 404)
    end

    desc "Create a user."
    params do
      requires :first_name, type: String, desc: "The User first name"
      requires :last_name,  type: String, desc: "The User last name"
      requires :email,      type: String, desc: "The User email address"
      requires :password,   type: String, desc: "The User password"
    end
    post do
      User.create!(:first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
        :password => params[:password])
    end

    desc "Update a User."
    params do
      requires :first_name, type: String, desc: "The User first name"
      requires :last_name,  type: String, desc: "The User last name"
      requires :email,      type: String, desc: "The User email address"
      requires :password,   type: String, desc: "The User password"
    end
    put ':id' do
      authenticate! params[:access_token]
      user = User.find_by_id(params[:id]) || error!("Not Found", 404)
      user.update(:first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
        :password => params[:password])
      user
    end

    desc "Login as a user"
    params do
      requires :email,     type: String, desc: "The User first name"
      requires :password,  type: String, desc: "The User last name"
    end
    get do
      user = User.find_by_email(params[:email]) || error!("Not Found", 404)
      if user.authenticate(params[:password])
        return AccessToken.create!
      else
        error!('401 Unauthorized', 401)
      end
    end
  end
end
