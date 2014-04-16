class BooksV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  resource :books do
    desc "Returns book search results."
    params do
      requires :search_text, type: String, desc: "search text."
    end
    get do
      GoogleBook.search(params[:search_text])
    end
  end
end
