class ManualController < ApplicationController
  def show
    @show_details_1 = params[:button1].present?
    @show_details_2 = params[:button2].present?
    @show_details_3 = params[:button3].present?
  end
end
