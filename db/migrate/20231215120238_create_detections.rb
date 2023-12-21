# frozen_string_literal: true

class CreateDetections < ActiveRecord::Migration[7.1]
  def change
    create_table :detections do |t|
      t.references :report, foreign_key: true, null: false
      t.string :caller, null: false

      t.timestamps
    end

    add_index :detections, %i[report_id caller], unique: true
    add_index :detections, :caller
  end
end
