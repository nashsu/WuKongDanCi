class Chapter < ActiveRecord::Base
  belongs_to :dict
  has_many :word_chapters, dependent: :destroy
  has_many :words, :through => :word_chapters

end
