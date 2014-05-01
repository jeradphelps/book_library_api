class BookInstance < ActiveRecord::Base

  belongs_to :book
  belongs_to :user
  has_one :loan

  def self.search search_text
    joins(:book).where("lower(books.title) like '%#{search_text.downcase}%' or lower(books.author) like '%#{search_text.downcase}%'")
  end
end
