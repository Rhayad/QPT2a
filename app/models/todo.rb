class Todo < ActiveRecord::Base
    attr_accessible :title, :user_id, :deadline, :rl_description, :rp_description, :rp_title, :prestories_quest_id
    attr_accessor  :assign

 	belongs_to :user, 	 :class_name => "User", :foreign_key => "user_id"
    belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
    belongs_to :group, 	 :class_name => "Group", :foreign_key => "group_id"
    has_many :todo_users, :foreign_key => "todo_id", :dependent => :destroy

 	accepts_nested_attributes_for :todo_users

    validates :title,   :presence => true , :length => { :maximum => 50 }
    validates :user_id,   :presence => true
end