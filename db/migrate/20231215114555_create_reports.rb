# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.string :name, null: false
      t.string :uri, null: false

      t.timestamps
    end

    add_index :reports, :name
    add_index :reports, %i[name uri], unique: true
  end
end
