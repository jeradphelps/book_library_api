class Loan < ActiveRecord::Base

  belongs_to :book_instance
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'
  belongs_to :borrower, class_name: 'User', foreign_key: 'borrower_id'

  before_create :set_requested

  private

    def set_requested
      self.requested_at = Time.now
    end

end
