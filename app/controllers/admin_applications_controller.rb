class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show

  end

end
