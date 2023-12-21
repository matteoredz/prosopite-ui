# frozen_string_literal: true

class AddResolvedToCallStacks < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up   { add_column :call_stacks, :resolved, :boolean, null: false, default: false }
      dir.down { remove_column :call_stacks, :resolved, :boolean, null: false, default: false }
    end
  end
end
