class Project < ActiveRecord::Base
    
    attr_accessible :title, :teaser, :user_id, :prestories_id

    belongs_to :group, :class_name => "Group", :foreign_key => "group_id"
    has_many :todos, :dependent => :destroy

    accepts_nested_attributes_for :todos

    validates :title,   :presence => true , :length => { :maximum => 50 }
    validates :user_id, :presence => true
    validates :group_id, :presence => true

    default_scope :order => 'projects.created_at DESC'
end
