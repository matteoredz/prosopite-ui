# frozen_string_literal: true

namespace :prosopite do
  desc "Imports prosopite logs file"
  task :import, %i[uri] => :environment do |_, args|
    uri_string = args.fetch(:uri)
    Prosopite::ImportReport.call(uri: URI.parse(uri_string))
  end
end
