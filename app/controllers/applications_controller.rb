class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search_text].present?
      @pets = Pet.search(params[:search_text])
    else
      @pets = []
    end
  end

  def new
    @error_message = params[:error_message]
  end

  def create
    if params[:applicant_name].present? && params[:street_address].present? && params[:city].present? && params[:state].present? && params[:zip_code].present?
      application = Application.create(
        applicant: params[:applicant_name],
        applicant_address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}" ,
        description: '.',
        status: 'In Progress'
      )
      redirect_to "/applications/#{application.id}"
    else
      error_message = 'Error: You did not fill in all required fields'
      redirect_to controller: 'applications', action: 'new', error_message: error_message
    end
  end

  def update
    if params[:pet_id].present?
      ApplicationPet.create(application_id: params[:id], pet_id: params[:pet_id])

    end
    redirect_to "/applications/#{params[:id]}"
  end

end
