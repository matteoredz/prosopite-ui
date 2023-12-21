# frozen_string_literal: true

module Prosopite
  class ImportReport < Actor
    input :name, type: String, allow_nil: true, default: nil
    input :uri, type: URI

    play DownloadLogZip
    play ProcessLogs
  end
end
