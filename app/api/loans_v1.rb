class LoansV1 < Grape::API
  version 'v1', using: :header, vendor: 'appydays'
  format :json

  before do
    authenticate! params[:access_token]
  end

  params do
    optional :access_token, type: String, desc: "access token."
  end
  resource :loans do

    desc "Request to borrow a book"
    params do
      requires :book_instance_id, type: Integer, desc: "Requested book instance id."
      requires :user_id, type: Integer, desc: "User id of requisting user."
    end
    post 'request' do
      book = BookInstance.where(id: params[:book_instance_id]).first

      if book.present?
        loan = Loan.create(
          book_instance_id: book.id,
          lender_id: book.user_id,
          borrower_id: params[:user_id]
        )
      end
    end

    desc "View pending requests."
    params do
      requires :user_id, type: String, desc: "User id."
    end
    get 'pending' do
      loans = Loan.where(lender_id: params[:user_id], approved: false)

      loans.map do |l|
        l.for_api
      end
    end

    desc "Approve a loan request"
    params do
      requires :id, type: Integer, desc: "Id of the loan."
    end
    post ':id/approve' do
      loan = Loan.where(id: params[:id]).first

      if loan.present?
        loan.approved = true
        loan.lent_at = Time.now
        loan.due_on = 1.month.from_now

        loan.save!

        loan
      end
    end

    desc "Deny a loan request"
    params do
      requires :id, type: Integer, desc: "Id of the loan."
    end
    post ':id/deny' do
      loan = Loan.where(id: params[:id]).first

      if loan.present?
        loan.destroy!
      end
    end

    desc "View lent books."
    params do
      requires :user_id, type: String, desc: "User id."
    end
    get 'lent' do
      loans = Loan.where(lender_id: params[:user_id], approved: true, returned: false)

      loans.map do |l|
        l.for_api
      end
    end

    desc "Return a book."
    params do
      requires :id, type: Integer, desc: "Id of the loan."
    end
    post ':id/return' do
      loan = Loan.where(id: params[:id]).first

      if loan.present?
        loan.returned = true

        loan.save!
      end
    end

    desc "View borrowed books."
    params do
      requires :user_id, type: String, desc: "User id."
    end
    get 'borrowed' do
      loans = Loan.where(borrower_id: params[:user_id], approved: true, returned: false)

      loans.map do |l|
        l.for_api
      end
    end
  end
end
