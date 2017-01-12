class ThicknessBlocksController < ApplicationController

  before_action :check_user_permission
  before_action :set_block, only: [:destroy, :update, :reset_weight]

  def destroy
    if @access_level.access_level == 3
      @thickness_block.is_deleted = true
      @thickness_block.deleted_by = current_user.id
      if @thickness_block.save
        redirect_to thickness_index_url, notice: 'Successfully deleted block of thickness checks.'
      else
        redirect_to thickness_index_url, flash: { error: 'Error deleting block of thickness checks. Please contact IT.' }
      end
    else
      redirect_to thickness_index_url, flash: { error: 'You do not have permission to delete blocks of thickness checks.' }
    end
  end

  def update
    if @thickness_block.update thickness_block_params
      redirect_to thickness_index_url
    else
      redirect_to thickness_index_url, flash: { error: 'Error updating load weight. Please try again or contact IT.' }
    end
  end

  def reset_weight
    @thickness_block.pounds = nil
    if @thickness_block.save
      redirect_to thickness_index_url
    else
      redirect_to thickness_index_url, flash: { error: 'Error resetting weight. Please contact IT.' }
    end
  end

private

  def check_user_permission
    check_permission 'thickness_checks'
  end

  def set_block
    @thickness_block = ThicknessBlock.find params[:id]
  end

  def thickness_block_params
    params.require(:thickness_block).permit(:pounds)
  end

end