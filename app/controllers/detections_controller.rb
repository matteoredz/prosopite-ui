# frozen_string_literal: true

class DetectionsController < ApplicationController
  before_action :set_report
  before_action :set_detection, only: :resolve

  def index
    detections = @report.detections
    detections = detections.where("caller LIKE ?", "%#{query}%") if query

    @pagy, @detections = pagy(detections)
  end

  def resolve
    respond_to do |format|
      if @detection.resolve_in_cascade
        format.html do
          redirect_to report_detections_path,
                      notice: "Detection #{@detection.id} was resolved."
        end
      else
        flash.now.alert = @detection.human_errors
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

    def query
      params[:q]&.downcase
    end
end
