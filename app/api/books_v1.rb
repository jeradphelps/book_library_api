class BooksV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    requires :access_token, type: String, desc: "access token."
  end
  resource :books do

    desc "Returns book search results."
    params do
      requires :search_text, type: String, desc: "search text."
    end
    get do
      GoogleBook.search(params[:search_text], request.env["REMOTE_ADDR"])
    end
  end
end
