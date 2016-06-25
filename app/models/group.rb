class Group < ActiveRecord::Base
  has_many :keywords, dependent: :destroy
end
