class User < ActiveRecord::Base

  has_many :book_instances

  has_secure_password

end
