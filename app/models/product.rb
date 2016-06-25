class Product < ActiveRecord::Base
  belongs_to :keyword

  def to_hash
    ActiveSupport::JSON.decode(self.to_json)
  end

end
