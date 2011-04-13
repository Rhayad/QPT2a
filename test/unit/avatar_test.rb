require 'test_helper'

class AvatarTest < ActiveSupport::TestCase
 	
 	# Set New Skill Points
	test "should increase avatars skillpoints" do
		
		@avatar = Avatar.find(1)
		oldSkillPoints = @avatar.skillPoints			
		assert_equal 0, oldSkillPoints

		Avatar.new.setAvatarSkillPoints(1, 30)
		
		@newAvatar = Avatar.find(1)
		newSkillPoints = @newAvatar.skillPoints
		assert_equal 5, newSkillPoints
 	end
end