class Dict < ActiveRecord::Base
	has_many :chapters, dependent: :destroy
end
