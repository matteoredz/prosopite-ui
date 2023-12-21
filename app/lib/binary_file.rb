# frozen_string_literal: true

class BinaryFile
  def initialize
    @temp_file = Tempfile.new
    @temp_file.binmode
  end

  def write(io)
    temp_file.write(io)
    temp_file.rewind
  end

  def path
    temp_file.path
  end

  def recycle
    temp_file.close
    temp_file.unlink
  end

  private

    attr_reader :temp_file
end
