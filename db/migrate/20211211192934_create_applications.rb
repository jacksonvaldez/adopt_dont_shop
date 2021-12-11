class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant
      t.string :applicant_address
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
