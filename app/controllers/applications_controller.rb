class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @searched_pets = Pet.search(params[:search_text])
  end

  def new
  end

  def create
    application = Application.new(
      applicant: params[:applicant_name],
      applicant_address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}" ,
      description: '.',
      status: 'In Progress'
    )
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = 'Error: You did not fill in all required fields'
      redirect_to controller: 'applications', action: 'new'
    end
  end

  def update
    application = Application.find(params[:id])
    params[:pet_id].present? ? ApplicationPet.create(application_id: params[:id], pet_id: params[:pet_id]) : nil
    params[:owner_description].present? ? application.update(description: params[:owner_description], status: 'Pending') : nil
    redirect_to "/applications/#{params[:id]}"
  end

end
