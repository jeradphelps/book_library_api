class BookInstancesV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    optional :access_token, type: String, desc: "access token."
  end
  resource :book_instances do
    desc "Search for book instances."
    params do
      optional :search_text, type: String, desc: "Search Text--title or author."
      optional :user_id, type: Integer, desc: "user_id of book instance owner."
    end
    get do
      BookInstance.search(params).map do |b|
        b.attributes.merge({
          book: b.book,
          user: {
            first_name: b.user.first_name,
            last_name: b.user.last_name,
            city_state_str: b.user.city_state_str
          }
        })
      end
    end

    desc "Return a book instance."
    params do
      requires :id, type: Integer, desc: "Status id."
    end
    get ':id' do
      book_instance = BookInstance.find_by_id(params[:id])

      if book_instance.present?
        book_instance.attributes.merge({
          book: book_instance.book.attributes.merge({
            rating: book_instance.book.rating
          }),
          user: {
            first_name: book_instance.user.first_name,
            last_name: book_instance.user.last_name,
            city_state_str: book_instance.user.city_state_str
          }
        })
      else
        error!("Not Found", 404)
      end
    end

    desc "Create a book instance."
    params do
      requires :title,  type: String, desc: "The Book title"
      requires :genre,  type: String, desc: "The Book genre"
      requires :isbn,   type: String, desc: "The Book isbn"
      requires :author, type: String, desc: "The Book author"
      requires :user_id, type: String, desc: "The user who owns this book instance"
    end
    post do
      book = Book.where(
        isbn: params[:isbn],
        title: params[:title],
        genre: params[:genre],
        author: params[:author]
      ).first_or_create
      BookInstance.create!(:book_id => book.id, :user_id => params[:user_id])
    end

    desc "Update a Book Instance."
    params do
      requires :title,  type: String, desc: "The Book title"
      requires :genre,  type: String, desc: "The Book genre"
      requires :isbn,   type: String, desc: "The Book isbn"
      requires :author, type: String, desc: "The Book author"
    end
    put ':id' do
      book_instance = BookInstance.find_by_id(params[:id]) || error!("Not Found", 404)
      book_instance.update({
        isbn: params[:isbn],
        title: params[:title],
        genre: params[:genre],
        author: params[:author]
      })
      book_instance
    end

    desc "Delete a Book Instance."
    params do
      requires :id, type: Integer, desc: "Book Instance ID."
    end
    delete ':id' do
      book_instance = BookInstance.find_by_id(params[:id]) || error!("Not Found", 404)
      book_instance.destroy
    end
  end
end
