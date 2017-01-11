class ThicknessChecksController < ApplicationController

  before_action :check_user_permission
  before_action :set_check, only: [:destroy]

  def destroy
    if @access_level.access_level == 3
      if @thickness_check.destroy
        redirect_to thickness_index_url, notice: 'Successfully deleted thickness check.'
      else
        redirect_to thickness_index_url, flash: { error: 'Error deleting thickness check. Please contact IT.' }
      end
    else
      redirect_to thickness_index_url, flash: { error: 'You do not have permission to delete thickness checks.' }
    end
  end

private

  def check_user_permission
    check_permission 'thickness_checks'
  end

  def set_check
    @thickness_check = ThicknessCheck.find params[:id]
  end

end