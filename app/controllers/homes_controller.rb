class HomesController < ApplicationController
  def new
  	@time_record = TimeRecord.new
    @task = Task.new
    @tasks = Task.all
    @operation = "create"
    @status = "open"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_record }
    end
  end

  def start_time_record

    # unless params[:description].nil?

    # if Task.where(description: params[:description]).exists?

    #   task = Task.find_by_description(params[:description])
    #     else
    #   task = Task.create(description: params["description"])
    #   end
    #   @time_record = TimeRecord.new(state: "open", task_id: task.id)

    # else
        @time_record = TimeRecord.new(state: "open")

    end



    respond_to do |format|
      if @time_record.save
        # if task
        #   # task.time_records << @time_record
        # end
        format.html { redirect_to dashboard_path(@time_record), notice: 'Time record was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end



  def dashboard

  	@operation = "update"
    @status = "toallocate"
    # @task = Task.new
    # @tasks = Task.all

    @time_record = TimeRecord.find(params[:id])

    unless @time_record.task_id.nil?

      @task = Task.find(@time_record.task.id)
    else
      @task =Task.new
      @tasks= Task.where("description!=?","unallocated")
    end
  end



  def allocate_time_record
  	  @time_record = TimeRecord.find(params[:id])

    # binding.pry

    if !params[:Task].empty?

      @time_record.task = Task.find(params[:Task])

    elsif @time_record.task_id.nil?
      @task = Task.find_by_description("unallocated")
      # @time_record.task = @task
    end

    respond_to do |format|
      if @time_record.update_attributes(state: params["status"])
        # binding.pry
        @time_record.calculate_time(@time_record)

        if @time_record.task_id.nil?

          @time_record.task = @task
          @time_record.save
        end

        format.html { redirect_to time_records_path, notice: 'Time record was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end

  end

end
