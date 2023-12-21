# frozen_string_literal: true

class LogsBlock
  def initialize
    @current_block  = {}
    @is_query_block = false
    @is_stack_block = false
  end

  def query_block? = is_query_block
  def stack_block? = is_stack_block

  def reset
    self.current_block  = {}
    self.is_query_block = false
    self.is_stack_block = false
  end

  def new_query_block
    current_block[:queries] = []
    self.is_query_block = true
    self.is_stack_block = false
  end

  def new_stack_block
    current_block[:call_stack] = []
    self.is_query_block = false
    self.is_stack_block = true
  end

  def caller = call_stack&.first

  def parsed?
    !current_block.empty?
  end

  def call_stack = current_block[:call_stack]

  def append_caller(value)
    current_block[:call_stack] << value
  end

  def queries = current_block[:queries]

  def append_query(value)
    current_block[:queries] << value
  end

  def call_stack_md5 = md5(call_stack)
  def queries_md5    = md5(queries)

  private

    attr_accessor :current_block, :is_query_block, :is_stack_block

    def md5(ary)
      Digest::MD5.hexdigest(ary.join("..."))
    end
end
