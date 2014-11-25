class ReciteWord < ActiveRecord::Base
  belongs_to :recite_task
  belongs_to :word
  belongs_to :user
  belongs_to :dict
end
