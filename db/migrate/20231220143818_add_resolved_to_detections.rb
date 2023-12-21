# frozen_string_literal: true

class AddResolvedToDetections < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up   { add_column :detections, :resolved, :boolean, null: false, default: false }
      dir.down { remove_column :detections, :resolved, :boolean, null: false, default: false }
    end
  end
end
