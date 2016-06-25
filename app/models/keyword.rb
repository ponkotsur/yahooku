class Keyword < ActiveRecord::Base
  belongs_to :group
  has_many :products , dependent: :destroy
end
