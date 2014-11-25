class WordChapter < ActiveRecord::Base

  # validates_uniqueness_of :word_id, :chapter_id

  validates :word_id, uniqueness: { scope: :chapter_id }

  belongs_to :word
  belongs_to :chapter
end
