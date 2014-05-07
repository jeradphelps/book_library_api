class BooksV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    optional :access_token, type: String, desc: "access token."
  end
  resource :books do

    desc "Returns book search results."
    params do
      requires :search_text, type: String, desc: "search text."
    end
    get do
      GoogleBook.search(params[:search_text], request.env["REMOTE_ADDR"])
    end

    desc "Search for available books."
    params do
      requires :search_text, type: String, desc: "Search text."
    end
    get 'available' do
      Book.search(params[:search_text]).map{ |b| b.for_api }
    end

    desc "View lenders who have this book."
    params do
      requires :id, type: Integer, desc: "Book id."
    end
    get ':id/lenders' do
      book_instances = BookInstance.where(book_id: params[:id])

      book_instances.map do |b|
        {
          first_name: b.user.first_name,
          last_name: b.user.last_name,
          city_state_str: b.user.city_state_str,
          book_instance_id: b.id,
          book_id: b.book_id
        }
      end

    end
  end
end
