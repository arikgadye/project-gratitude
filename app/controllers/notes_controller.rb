class NotesController < ApplicationController
	protect_from_forgery :except => :create
	before_action :set_note, only: [:show, :edit, :update, :destroy]

	def all
		@note = Note.new
		@notes = Note.all
	end

	def new
		@note = Note.new
	end

	def create
		params[:note] = params[:note].merge(user_id: current_or_guest_user.id)
		@note = Note.new(note_params)
		respond_to do |format|
			if @note.save
				if !params[:image].nil?
					@image = Image.create(image_params)
					@note.images << @image
				end
				format.html { redirect_to root_path } # support a non-ajax call
				format.js
			else
				format.html { redirect_to root_path }
				format.js { render :template => 'notes/error.js.erb' }
			end
		end
	end

	def show
		@comment = Comment.new
		@comments = @note.comments
	end

	def like
	end

	def unlike
	end

	def edit
	end

	def update
	end

	def destroy
	end


	private
	def set_note
		@note = Note.find(params[:id])
	end

	def note_params
		params.require(:note).permit(:desc, :user_id)
	end

	def image_params
		params.require(:image).permit(:pic)
	end
end
