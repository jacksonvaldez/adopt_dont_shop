class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @error_message = params[:error_message]
  end

  def create
    if params[:applicant_name].present? && params[:street_address].present? && params[:city].present? && params[:state].present? && params[:zip_code].present?
      application = Application.create(
        applicant: params[:applicant_name],
        applicant_address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}" ,
        description: params[:description],
        status: 'In Progress'
      )
      redirect_to "/applications/#{application.id}"
    else
      error_message = 'Error: You did not fill in all required fields'
      redirect_to controller: 'applications', action: 'new', error_message: error_message
    end
  end

end
