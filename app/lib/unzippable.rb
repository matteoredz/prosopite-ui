# frozen_string_literal: true

require "fileutils"
require "zip"

module Unzippable
  extend ActiveSupport::Concern

  included do
    def unzipped(src, &)
      temp_file = BinaryFile.new
      temp_file.write(src)

      Zip::File.open(temp_file.path) do |entries|
        entry = entries.first

        Dir.mktmpdir do |dir|
          unzipped_path = File.join(dir, entry.name)
          FileUtils.mkdir_p(File.dirname(unzipped_path))
          entry.extract(unzipped_path)
          File.open(unzipped_path, "r", &)
        end
      end
    ensure
      temp_file.recycle
    end
  end
end
