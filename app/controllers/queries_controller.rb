# frozen_string_literal: true

class QueriesController < ApplicationController
  before_action :set_report, only: :index
  before_action :set_detection, only: :index
  before_action :set_call_stack, only: :index

  def index
    @pagy, @queries = pagy(@call_stack.queries)
  end

  private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_detection
      @detection = @report.detections.find(params[:detection_id])
    end

    def set_call_stack
      @call_stack = @detection.call_stacks.find(params[:call_stack_id])
    end
end
