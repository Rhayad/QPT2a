class Prestoryquest < ActiveRecord::Base
	attr_accessible :description #:title
	belongs_to :prestory
	validates :description,   :presence => true
	default_scope :order => 'prestoryquests.created_at ASC'
end
