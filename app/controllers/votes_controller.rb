class VotesController < ApplicationController

	# just create a vote, no need for new
	def create
		# because we are in the votes controller the story_id is found by params[:story_id]
		@story = Story.find(params[:story_id])
		# create instead of new as no need to worry about vailidations
		@vote = @story.votes.create

		flash[:success]="you have voted"

		# redirect_to story_path(@story)

		if params[:back_to] == "home"
			# go to the homepage
			redirect_to root_path
		else 
			# go to the story page
			redirect_to story_path(@story)
		end


	end
end
