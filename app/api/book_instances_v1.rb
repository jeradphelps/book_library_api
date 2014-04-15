class BookInstancesV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  resource :book_instances do
    desc "Return all book instances."
    get do
      # BookInstance.order("created_at asc")
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
      # requires :label, type: String, desc: "Todo label."
    end
    post do
      BookInstance.create!({
        # label: params[:label]
      })
    end

    desc "Update a Book Instance."
    params do
      requires :id, type: Integer, desc: "Book Instance ID."
      # requires :label, type: String, desc: "Todo label."
    end
    put ':id' do
      book_instance = BookInstance.find_by_id(params[:id]) || error!("Not Found", 404)
      book_instance.update({
        # label: params[:label],
        # done: params[:done]
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
