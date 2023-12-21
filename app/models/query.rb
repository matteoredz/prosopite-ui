# frozen_string_literal: true

class Query < ApplicationRecord
  belongs_to :call_stack

  validates :md5, presence: true, uniqueness: { scoped: :call_stack }
  validates :optimizable_list, presence: true
end
