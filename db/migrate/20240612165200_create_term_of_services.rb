class CreateTermOfServices < ActiveRecord::Migration[5.2]
  def change
    create_table :term_of_services do |t|
      t.text :text

      t.timestamps
    end
  end
end
