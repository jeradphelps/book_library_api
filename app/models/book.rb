class Book < ActiveRecord::Base

  has_many :book_instances

  def self.search search_text
    where("lower(books.title) like '%#{search_text.downcase}%' or lower(books.author) like '%#{search_text.downcase}%'")
  end

end
