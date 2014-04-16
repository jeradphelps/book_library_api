class GoogleBook
  def initialize(title, authors, genres, isbn_13, image_link)
    @title = title
    @authors = authors
    @genres = genres
    @isbn_13 = isbn_13
    @image_link = image_link
  end

  def self.search str
    GoogleBooks.search(str, {:count => 10}).map do |g_book|
      GoogleBook.new(g_book.title, g_book.authors, g_book.categories, g_book.isbn_13, g_book.image_link)
    end
  end
end