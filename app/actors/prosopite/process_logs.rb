# frozen_string_literal: true

module Prosopite
  class ProcessLogs < Actor
    include Unzippable

    input :report, type: Report

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def call
      unzipped(report.zipped_report.download) do |file|
        logs_block = LogsBlock.new

        file.each_line do |line|
          next if line.squish!.blank?

          # Ended a previous block, do the block parsing magic!
          if line == "N+1 queries detected:" && logs_block.parsed?
            report.store_detection(logs_block)
            logs_block.reset
          end

          if line == "N+1 queries detected:" && !logs_block.query_block?
            logs_block.new_query_block
            next
          end

          if line == "Call stack:" && !logs_block.stack_block?
            logs_block.new_stack_block
            next
          end

          logs_block.append_query(line)  if logs_block.query_block?
          logs_block.append_caller(line) if logs_block.stack_block?
        end
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
