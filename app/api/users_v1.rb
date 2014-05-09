class UsersV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  params do
    optional :access_token, type: String, desc: "access token."
  end
  resource :users do

    desc "Return a User"
    params do
      requires :id, type: Integer, desc: "ID of user."
    end
    get ':id' do
      authenticate! params[:access_token]
      User.find_by_id(params[:id]) || error!("Not Found", 404)
    end

    desc "Create a user."
    params do
      requires :first_name, type: String, desc: "The User first name"
      requires :last_name,  type: String, desc: "The User last name"
      requires :email,      type: String, desc: "The User email address"
      requires :password,   type: String, desc: "The User password"
      requires :city_state_str,   type: String, desc: "The User city state string"
    end
    post do
      User.create!(:first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
        :password => params[:password],
        :city_state_str => params[:city_state_str])
    end

    desc "Update a User."
    params do
      requires :id, type: Integer, desc: "The User Id"
      requires :first_name, type: String, desc: "The User first name"
      requires :last_name,  type: String, desc: "The User last name"
      requires :email,      type: String, desc: "The User email address"
      optional :password,   type: String, desc: "The User password"
      requires :city_state_str,   type: String, desc: "The User city state string"
    end
    put ':id' do
      authenticate! params[:access_token]
      user = User.find_by_id(params[:id]) || error!("Not Found", 404)
      user.update(:first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
        :city_state_str => params[:city_state_str])

      user.update(:password => params[:password]) if params[:password].present?
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
        token = AccessToken.create!

        { token: token.token, user: user }
      else
        error!('401 Unauthorized', 401)
      end
    end

    desc "Send user password reset information."
    params do
      requires :email, type: String, desc: "The User email address"
    end
    post 'send_password_reset' do
      user = User.find_by_email(params[:email])

      if user.present?
        # TODO: send an email to user
        true
      else
        error!("Not Found", 404)
      end
    end

  end
end
