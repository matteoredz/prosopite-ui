# frozen_string_literal: true

class CreateCallStacks < ActiveRecord::Migration[7.1]
  def change
    create_table :call_stacks do |t|
      t.references :detection, foreign_key: true, null: false
      t.string :md5, null: false
      t.string :subroutines, array: true, null: false

      t.timestamps
    end

    add_index :call_stacks, %i[detection_id md5], unique: true
    add_index :call_stacks, :subroutines, using: "gin"
  end
end
