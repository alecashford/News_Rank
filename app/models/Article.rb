class Article < ActiveRecord::Base
 belongs_to :feed
 validates :canonical_url, uniqueness: true
end
