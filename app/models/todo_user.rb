class TodoUser < ActiveRecord::Base

	attr_accessible :user_id, :todo_id, :gold, :xp, :isQueueDone, :isProved

	belongs_to :todo, :class_name => "Todo", :foreign_key => "todo_id"
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"

	validates :user_id,   :presence => true
	validates :todo_id,   :presence => true
end
