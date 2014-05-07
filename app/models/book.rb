class Book < ActiveRecord::Base

  has_many :book_instances
  has_many :reviews

  def self.search search_text
    where("lower(books.title) like '%#{search_text.downcase}%' or lower(books.author) like '%#{search_text.downcase}%'")
  end

  def rating
    reviews.average(:rating) || ''
  end

end
