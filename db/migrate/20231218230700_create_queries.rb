# frozen_string_literal: true

class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.references :call_stack, foreign_key: true, null: false
      t.string :md5, null: false
      t.string :optimizable_list, array: true, null: false

      t.timestamps
    end

    add_index :queries, %i[call_stack_id md5], unique: true
    add_index :queries, :optimizable_list, using: "gin"
  end
end
