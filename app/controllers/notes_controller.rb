class NotesController < ApplicationController
  def create

  	# binding.pry

  	@note = Note.new(content:params[:note][:content], task_id: params[:note_task_id])

  	respond_to do |format|
  		if @note.save
  			@task = Task.find(params[:note_task_id])
  			@task.notes << @note
  			format.js
  		end
  	end
  end

  def index

    @notes = Note.where(task_id: params[:task_id])

    respond_to do |format|
      format.json {render json: @notes}
    end

  end



end
