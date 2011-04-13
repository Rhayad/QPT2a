class Group < ActiveRecord::Base
    attr_accessible :title

    belongs_to :user
    has_many :projects, :dependent => :destroy
    has_many :todos, :through => :projects ,:dependent => :destroy
    has_many :group_members, :foreign_key => "group_id", :dependent => :destroy

    accepts_nested_attributes_for :projects
    accepts_nested_attributes_for :todos
    accepts_nested_attributes_for :group_members
        
    validates :title,   :presence => true, :length => { :maximum => 60 }
    validates :user_id, :presence => true    
    
    before_create :create_group

    # Order by
    default_scope :order => 'groups.created_at DESC'   
    
    private
      def create_group
        groupjoin = group_members.build(:user => user)
      end
    
end