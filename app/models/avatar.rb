class Avatar < ActiveRecord::Base
	attr_accessible :user_id, :gold, :strength, :ability, :endurance, :intelligence
	belongs_to :user

	SKILL_POINTS 	= 5
	MAX_LEVEL		= 50
	XP_FOR_LEVELUP	= 30

	def getAvatarGold(userID)
		userGold = TodoUser.where(:isProved => true, :user_id => userID).sum("gold")
	end

	def getAvatarXp(userID)
		userXp = TodoUser.where(:isProved => true, :user_id => userID).sum("xp")
	end

	def getLevel(userID)
		userXp = getAvatarXp(userID) / XP_FOR_LEVELUP
 	end

	def getSkillPoints(userID)
		skills = Avatar.find_by_user_id(userID)
		skills.skillPoints
	end

	def setAvatarSkillPoints(userID, newXP)
        avatar = Avatar.find_by_user_id(userID)
        oldLevel = avatar.getLevel(userID)
        newLevel = 0
        currentSkillPoints = avatar.skillPoints
 		newLevel = (getAvatarXp(userID) + Integer(newXP)) / XP_FOR_LEVELUP
       	
        if oldLevel < newLevel
	       	addSkillPoints = Integer(currentSkillPoints) + SKILL_POINTS * (newLevel - oldLevel)
            avatar.update_attribute(:skillPoints, addSkillPoints)                        
        end
    end
end