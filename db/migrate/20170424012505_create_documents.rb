class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user, index: true

      t.string :name
      t.text :description
      t.binary :schema_file

      t.timestamps null: false
    end
  end
end
