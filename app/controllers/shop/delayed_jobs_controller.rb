class Shop::DelayedJobsController < ApplicationController
  load_and_authorize_resource

  def index
    @delayed_jobs = @delayed_jobs.ordered
  end

  def destroy
    @delayed_job.destroy
    respond_with @delayed_job
  end

end
