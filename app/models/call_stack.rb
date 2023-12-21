# frozen_string_literal: true

class CallStack < ApplicationRecord
  belongs_to :detection

  has_many :queries, dependent: :destroy

  validates :md5, presence: true, uniqueness: { scoped: :detection }
  validates :subroutines, presence: true

  scope :unresolved, -> { where(resolved: false) }
end
