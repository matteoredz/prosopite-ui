# frozen_string_literal: true

class ProcessReportJob < ApplicationJob
  queue_as :default

  def perform(report)
    Prosopite::ImportReport.call(name: report.name, uri: URI.parse(report.uri))
  end
end
