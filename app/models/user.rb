class User < ActiveRecord::Base

  has_many :book_instances

  has_secure_password

  def for_api
    {
      first_name: self.first_name,
      last_name: self.last_name,
      city_state_str: self.city_state_str
    }
  end

end
