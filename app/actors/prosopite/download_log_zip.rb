# frozen_string_literal: true

require "net/http"

module Prosopite
  class DownloadLogZip < Actor
    input :name, type: String, allow_nil: true, default: nil
    input :uri, type: URI

    output :report, type: Report

    def call
      temp_file = Tempfile.new

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(Net::HTTP::Get.new(uri)) do |response|
          fail!(error: response.class.to_s) unless response.is_a?(Net::HTTPOK)

          basename = File.basename(uri.path)

          temp_file.binmode
          temp_file.write(response.body)
          temp_file.rewind

          self.report = Report.find_or_create_by(name: name.presence || basename, uri: uri.to_s)

          unless report.zipped_report.attached?
            report.zipped_report.attach(io: temp_file, filename: basename)
          end
        end
      end
    rescue StandardError => e
      fail!(error: e.message)
    ensure
      temp_file.close
      temp_file.unlink
    end
  end
end
