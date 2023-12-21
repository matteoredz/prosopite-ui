# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :detections, dependent: :destroy

  has_one_attached :zipped_report

  validates :name, presence: true, uniqueness: { scoped: :uri }
  validates :uri, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  # TODO
  #
  # Performances could be improved by using something like 'insert_all' or 'activerecord-import'
  # (Yeah, it's ugly, but at least works, and looks functional!)
  def store_detection(logs_block)
    ActiveRecord::Base.transaction do
      detections
        .find_or_create_by!(caller: logs_block.caller)
        .call_stacks
        .create_with(subroutines: logs_block.call_stack)
        .find_or_create_by!(md5: logs_block.call_stack_md5)
        .queries
        .create_with(optimizable_list: logs_block.queries)
        .find_or_create_by!(md5: logs_block.queries_md5)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "#{e.class}: #{e.message}"
      raise ActiveRecord::Rollback
    end
  end
end
