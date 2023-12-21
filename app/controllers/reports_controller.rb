# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @pagy, @reports = pagy(Report.all.order(id: :desc))
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        ProcessReportJob.perform_later(@report)
        format.html { redirect_to reports_path, notice: "Report was successfully created." }
      else
        flash.now.alert = @report.human_errors
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

    def report_params
      params.require(:report).permit(:name, :uri)
    end
end
