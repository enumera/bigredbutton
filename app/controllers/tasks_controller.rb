class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    update_time(@tasks)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create

    @task = Task.new(params[:task])

     @task.hours = 0
    @task.minutes = 0
    # binding.pry
    if params["time_record"]
      time_record = TimeRecord.find(params["time_record"])
    end

    # binding.pry

    respond_to do |format|
      if @task.save
      
        if time_record
          @task.time_records << time_record
        end
        format.js
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private


  def update_time(tasks)

    tasks.each do |p|

      unless  p.time_records.where(state: "toallocate").empty?

        time_records = p.time_records.where(state: "toallocate")

        hours =  time_records.map {|t| t.hours}.reduce(:+)
        minutes = time_records.map {|t| t.minutes}.reduce(:+)

      

        if minutes >= 60 

          hours_to_add = minutes/60
       
          hours +=hours_to_add
         
          minutes  = minutes - hours_to_add * 60
  
        end

        
        p.hours += hours
        p.minutes += minutes


      

        if p.minutes > 59

           hours_to_add_x = p.minutes/60

           p.hours += hours_to_add_x

           p.minutes = p.minutes - hours_to_add_x * 60

        end

        p.save

        time_records.each do |tr|
          tr.state = "closed"
          tr.save
        end
      end
    end
  end
end
