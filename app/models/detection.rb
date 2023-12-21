# frozen_string_literal: true

class Detection < ApplicationRecord
  belongs_to :report

  has_many :call_stacks, dependent: :destroy
  has_many :queries, through: :call_stacks

  validates :caller, presence: true, uniqueness: { scoped: :report }

  scope :unresolved, -> { where(resolved: false) }

  def resolve_in_cascade
    ActiveRecord::Base.transaction do
      return true if update(resolved: true) && call_stacks.unresolved.update_all(resolved: true)

      raise ActiveRecord::Rollback
    end

    false
  end
end
