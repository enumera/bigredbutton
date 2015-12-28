class NotesController < ApplicationController
  def create

  	# binding.pry

  	@note = Note.create(content:params[:note_content])

  end
end
