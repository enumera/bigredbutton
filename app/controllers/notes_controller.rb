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

    @notes = Note.where(task_id: params[:task_id]).order("created_at DESC").limit(6)

    respond_to do |format|
      format.json {render json: @notes}
    end

  end

  def show
     @notes = Note.where(task_id: params[:task_id]).order("created_at DESC").limit(6)

    respond_to do |format|
      format.json {render json: @notes}
    end

  end
  

  def index_all
    @notes = Note.all

  end

  def edit
    @note = Note.find(params[:id])
  end

    def update
    @note = Note.find(params[:id])
    @task = @note.task

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end



end
