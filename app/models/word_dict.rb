class WordDict < ActiveRecord::Base
  belongs_to :word
  belongs_to :dict
end
