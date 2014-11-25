class Word < ActiveRecord::Base
	has_many :word_chapters, dependent: :destroy

end
