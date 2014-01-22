class StoriesController < ApplicationController

	# before we run the edit, show, update and destroy
	# lets find the story we are talking about
	before_action :find_story, only: [:show, :edit, :update, :destroy]

# controllers manage the urls, the data from the models 
# and the html views

	def index
		@username = "michael"
		@now = Time.now
		#@stories = ["Google", "Twitter", "LinkedIn", "Facebook"]

		# set the veriable to @stories to all the records in our story database


# if it has ?sort=recent in the url then sort by created_at
# if it has nothing then do the popular ones
		if params[:sort] == "recent"
			# sort by createed_at
			@stories=Story.order("created_at desc")
		
		elsif params[:sort] == "featured"
			# sort by featured
			@stories = Story.where(is_featured: true).order("is_featured desc, title asc")
		else
			# sort by popular
			@stories = Story.order("votes_count desc, title desc")
		end
		# add in pagination, overwrite the @stories varible with the pagination version
		@stories = @stories.page(params[:page]).per(5)
	end

	def show
	# this is the individual story page, find the params id - is the numbner in the url
		# @story = Story.find(params[:id])

	end

# this is the new story form page
	def new 
		#verible @story goes to the view
		#Story.new comes from the model
		@story = Story.new

	end

#this is where the form data from the new.html.erb view goes
	def create
		@story = Story.new(story_params)

		if @story.save 

			#add a flash message when the story is added, needs to be before redirect
			flash[:success] = "you have added a story"

			# go to home page when saving
			redirect_to root_path

		else
			render "new"

		end

	end

	def edit
		#  show the edit form
		# @story = Story.find(params[:id])

	end

	def update 
		# update the database and save
		# @story = Story.find(params[:id])
		if 	@story.update(story_params)
			flash[:success] = "well done"
			redirect_to story_path(@story)
		else
			render "edit"
		end

	end

	def destroy
		# to delete any records
		# @story = Story.find(params[:id])
		@story.destroy
		flash[:success] = "you have deleted the story"
		redirect_to root_path

	end

# shortcut for getting form data
	def story_params
		params.require(:story).permit(:title, :description, :url, :tag_list)
	end
# shortcut for finding a story from the url
#  find story is not part of rails, but is a timesaving task created by ourseleves
	def find_story
		@story = Story.find(params[:id])

	end
end
