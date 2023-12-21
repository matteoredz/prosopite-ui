# frozen_string_literal: true

class CallStacksController < ApplicationController
  before_action :set_report
  before_action :set_detection
  before_action :set_call_stack, only: :resolve

  def index
    @pagy, @call_stacks = pagy(@detection.call_stacks)
  end

  def resolve
    respond_to do |format|
      if @call_stack.update(resolved: true)
        format.html do
          redirect_to report_detection_call_stacks_path,
                      notice: "Call stack #{@call_stack.id} was resolved."
        end
      else
        flash.now.alert = @call_stack.human_errors
        format.html { render :index, status: :unprocessable_entity }
      end
    end
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
