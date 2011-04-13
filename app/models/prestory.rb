class Prestory < ActiveRecord::Base
	attr_accessible :teaser
	has_many :prestoryquests, :dependent => :destroy
	validates :teaser,   :presence => true
end
