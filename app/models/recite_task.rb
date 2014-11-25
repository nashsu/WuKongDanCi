class ReciteTask < ActiveRecord::Base
  belongs_to :user
  has_many :recite_words, dependent: :destroy
end
