# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def human_errors = errors.full_messages.join(", ")
end
