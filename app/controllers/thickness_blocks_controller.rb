class ThicknessBlocksController < ApplicationController

  before_action :check_user_permission
  before_action :set_block, only: [:destroy]

  def destroy
    if @access_level.access_level == 3
      if @thickness_block.destroy
        redirect_to thickness_index_url, notice: 'Successfully deleted block of thickness checks.'
      else
        redirect_to thickness_index_url, flash: { error: 'Error deleting block of thickness checks. Please contact IT.' }
      end
    else
      redirect_to thickness_index_url, flash: { error: 'You do not have permission to delete blocks of thickness checks.' }
    end
  end

private

  def check_user_permission
    check_permission 'thickness_checks'
  end

  def set_block
    @thickness_block = ThicknessBlock.find params[:id]
  end

end