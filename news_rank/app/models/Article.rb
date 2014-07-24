class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :scores
end
