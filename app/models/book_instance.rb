class BookInstance < ActiveRecord::Base

  belongs_to :book

  def self.search search_text
    joins(:book).where("lower(books.title) like '%#{search_text.downcase}%' or lower(books.author) like '%#{search_text.downcase}%'")
  end
end
