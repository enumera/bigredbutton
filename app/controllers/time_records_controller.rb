class TimeRecordsController < ApplicationController
  # GET /time_records
  # GET /time_records.json
  def index
    @time_records = TimeRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_records }
    end
  end

  # GET /time_records/1
  # GET /time_records/1.json
  def show
    @time_record = TimeRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_record }
    end
  end

  # GET /time_records/new
  # GET /time_records/new.json
  def new
    @time_record = TimeRecord.new
    @task = Task.new
    # @note = Note.new
    @tasks = Task.all
    @operation = "create"
    @status = "open"


    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /time_records/1/edit
  def edit
    @operation = "update"
    @status = "toallocate"
    @note = Note.new
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

  # POST /time_records
  # POST /time_records.json
  def create

    # binding.pry

    unless params[:description].nil?

    if Task.where(description: params[:description]).exists?

      task = Task.find_by_description(params[:description])
        else
      task = Task.create(description: params["description"])
      end
      @time_record = TimeRecord.new(state: "open", task_id: task.id)

    else
        @time_record = TimeRecord.new(state: "open")

    end



    respond_to do |format|
      if @time_record.save
        if task
          task.time_records << @time_record
        end
        format.html { redirect_to edit_time_record_path(@time_record), notice: 'Time record was successfully created.' }
        format.json { render json: @time_record, status: :created, location: @time_record }
      else
        format.html { render action: "new" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_records/1
  # PUT /time_records/1.json
  def update
    @time_record = TimeRecord.find(params[:id])

    # binding.pry

    if @time_record.task_id.nil?

      if Task.all.count == 1
        # binding.pry

          @task = Task.find_by_description("unallocated")

      else


        if params[:Task].empty?
        # binding.pry


          @task = Task.find_by_description("unallocated")

        else 
        # binding.pry


          @task = Task.find(params[:Task])

        end

      end
    end

    # @time_record.task = @task

    respond_to do |format|
      if @time_record.update_attributes(state: params["status"])
        # binding.pry
        @time_record.calculate_time(@time_record)

        # binding.pry
        if @time_record.task_id.nil?
          @time_record.task = @task
          @time_record.save
        end


        format.html { redirect_to time_records_path, notice: 'Time record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_records/1
  # DELETE /time_records/1.json
  def destroy
    @time_record = TimeRecord.find(params[:id])
    @time_record.destroy

    respond_to do |format|
      format.html { redirect_to time_records_url }
      format.json { head :no_content }
    end
  end
end
