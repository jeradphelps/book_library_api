class BookInstancesV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    requires :access_token, type: String, desc: "access token."
  end
  resource :book_instances do
    desc "Return all book instances."
    params do
      requires :search_text, type: String, desc: "Search Text--title or author."
    end
    get do
      BookInstance.search(params[:search_text])
    end

    desc "Return a book instance."
    params do
      requires :id, type: Integer, desc: "Status id."
    end
    get ':id' do
      BookInstance.find_by_id(params[:id]) || error!("Not Found", 404)
    end

    desc "Create a book instance."
    params do
      requires :title,  type: String, desc: "The Book title"
      requires :genre,  type: String, desc: "The Book genre"
      requires :isbn,   type: String, desc: "The Book isbn"
      requires :author, type: String, desc: "The Book author"
    end
    post do
      book = Book.where(
        isbn: params[:isbn],
        title: params[:title],
        genre: params[:genre],
        author: params[:author]
      ).first_or_create
      BookInstance.create!(:book_id => book.id)
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
