class CreativeInputsController < ApplicationController
  def create
    @creative_input = CreativeInput.find_by(creative_input_tag: params['creative_input_tag'])
    if @creative_input
      render json: @creative_input, status: 200
    else
      @creative_input = CreativeInput.create!(permitted_params)
      render json: @creative_input, status: 201
    end
  end

  def show
    @creative_input = CreativeInput.find_by(creative_input_tag: params[:id])
    if @creative_input
      render json: @creative_input, status: 200
    else
      head :no_content
    end
  end

  private

  def permitted_params
    params.permit(:ad_input_id, :creative_message_id, :abtest_label_id,
                  :video_length_id, :start_month, :start_day, :end_month,
                  :end_day, :creative_input_tag, :custom,
                  :creative_version_number)
  end
end
