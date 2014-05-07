class ReviewsV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    optional :access_token, type: String, desc: "access token."
  end
  resource :reviews do

    desc "View reviews for a given book."
    params do
      requires :book_id, type: Integer, desc: "ID of book being reviewing."
    end
    post ':book_id' do
      Review.where(book_id: params[:book_id])
    end

    desc "Post a review"
    params do
      requires :book_id, type: Integer, desc: "ID of book being reviewing."
      requires :user_id, type: Integer, desc: "ID of user reviewing book."
      requires :rating, type: Integer, desc: "Rating of the book (1-10)."
      requires :comments, type: String, desc: "Text of the review."
    end
    post do
      Review.create(user_id: params[:user_id], book_id: params[:book_id], rating: params[:rating], comments: params[:comments])
    end
  end
end
