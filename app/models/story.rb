class Story < ActiveRecord::Base

	#  this is a connection in rails
	# our story has many comments
	has_many :comments
	has_many :votes

	# setup acts as taggable
	acts_as_taggable
	

	validates :title, presence: true, :length => { :minimum => 2 }
	validates :description, presence: true
	validates :url, presence: true, uniqueness: {message: "Has already been submitted"} 

	# I want to overwrite the url structure in active record
	#  the active record is the rails way to manage records
	# to_param is the method we want to overwrite
	def to_param
		"#{id}-#{title.parameterize}"
	end

	# this is my own shortcut to make nice clean url;s for our users
	def nice_url
		# i want to take thr url and remove http:// and www.
		# gsub is global subsitution
		url.gsub("http://", "").gsub("www.", "")
	end
end
