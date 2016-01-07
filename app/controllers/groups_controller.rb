class GroupsController < ApplicationController
  def index

	    @group = Group.where(id: params[:id]).includes(:tasks)
	    @tasks = @group[0].tasks

	    respond_to do |format|
	      format.js
	      format.json { render json: @tasks }
	    end

	end
end