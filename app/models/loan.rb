class Loan < ActiveRecord::Base

  belongs_to :book_instance
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'
  belongs_to :borrower, class_name: 'User', foreign_key: 'borrower_id'

  before_create :set_requested

  def for_api
    a = attributes.merge({
      book: book_instance.book.for_api,
      borrower: borrower.for_api,
      lender: lender.for_api
    })

    a[:requested_at] = requested_at.strftime('%m/%d/%Y') if requested_at.present?
    a[:lent_at] = lent_at.strftime('%m/%d/%Y') if lent_at.present?
    a[:due_on] = due_on.strftime('%m/%d/%Y') if due_on.present?

    a
  end

  private

    def set_requested
      self.requested_at = Time.now
    end

end
