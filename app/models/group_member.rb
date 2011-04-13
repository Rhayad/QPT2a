class GroupMember < ActiveRecord::Base

	attr_accessible :user, :group_id, :isInvited

	belongs_to :group, :foreign_key => "group_id"
	belongs_to :user, :foreign_key => "user_id"

	# validates :user_id,  :presence => true
	# validates :group_id,  :presence => true

	# Returns true if User is already in the group (invited or joined)
	def self.userIsAlreadyInGroup(groupID, userID)
        res = where(:group_id => groupID, :user_id => userID).all
        return res.empty?    
    end

    # List invited Users of Group
    # used in todos_controller - new (for select)
    def listUser(groupID)
		res = GroupMember.select("group_members.id, group_members.user_id ,group_members.group_id, users.username AS userName, users.id AS userID").where("group_id = ? AND isInvited = ?", groupID, 't').joins("LEFT JOIN users ON users.id = group_members.user_id")      
	end
end