class BookInstance < ActiveRecord::Base

  belongs_to :book
  belongs_to :user
  has_one :loan

  def self.search params
    return all if !params.any?
    result = all
    result = result.joins(:book).where("lower(books.title) like ? or lower(books.author) like ?", "%#{params[:search_text].downcase}%", "%#{params[:search_text].downcase}%") if params[:search_text].present?
    result = result.joins(:book).where("book_instances.user_id = ?", params[:user_id]) if params[:user_id].present?
  
    result
  end

  def for_api
    attributes.merge({
      book: book.for_api,
      user: user.for_api
    })
  end
end
