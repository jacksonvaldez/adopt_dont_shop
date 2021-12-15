class AdminApplicationsController < ApplicationsController

  def update
    application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    application_pet.update(status: params[:change_status_to])

    redirect_to(controller: 'admin_applications', action: :show)
  end

end
