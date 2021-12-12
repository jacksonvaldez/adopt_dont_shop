class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    if params[:applicant_name].present? && params[:street_address].present? && params[:city].present? && params[:state].present? && params[:zip_code].present?
      application = Application.create(
        applicant: params[:applicant_name],
        applicant_address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}" ,
        description: params[:description],
        status: 'Pending'
      )
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
    end
  end

end
