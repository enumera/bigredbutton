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
     @operation = "create"
     @status = "open"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_record }
    end
  end

  # GET /time_records/1/edit
  def edit
     @operation = "update"
     @status = "toallocate"

    @time_record = TimeRecord.find(params[:id])
    @task = Task.find(@time_record.task.id)
  end

  # POST /time_records
  # POST /time_records.json
  def create

    # binding.pry

    if Task.where(description: params[:description]).exists?

      task = Task.find_by_description(params[:description])
    else
      task = Task.create(description: params["description"])
    end

    @time_record = TimeRecord.new(state: "open", task_id: task.id)

    respond_to do |format|
      if @time_record.save
        task.time_records << @time_record
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

    respond_to do |format|
      if @time_record.update_attributes(state: params["status"])
        @time_record.calculate_time(@time_record)
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
