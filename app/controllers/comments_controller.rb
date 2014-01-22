class CommentsController < ApplicationController

	# add a comment to a story
	def new
		# so not params[:id]as this would refer to a comment, we need to find the story by the story id
		@story = Story.find(params[:story_id])
		# find the story and make a new comment on that story
		@comment = @story.comments.new
	end

	# actually get the form data and create a comment
	def create
		@story = Story.find(params[:story_id])
		@comment = @story.comments.new(comment_params)

		if @comment.save
			flash[:sucess] = "You've added a comment"
			redirect_to story_path(@story)
		else
			render "new"
		end


	end

	# lets make a shortcut for grabbing the form data
	# our white list for form datap
	def comment_params
		params.require(:comment).permit(:body)
	end
end
