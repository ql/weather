class JsonController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def process_params!(params)
    params[:user] = current_user if current_user
  end
end
