class OptoMessagesController < ApplicationController

  before_action :check_permission

  def index

    begin

      @filterrific = initialize_filterrific(
        OptoMessage,
        params[:filterrific],
        select_options: {
          sorted_by: OptoMessage.options_for_sorted_by,
          with_department: OptoMessage.options_for_department,
          with_type: OptoMessage.options_for_type,
          with_barrel: OptoMessage.options_for_barrel,
          with_lane: OptoMessage.options_for_lane
        }
      ) or return

      @opto_messages = @filterrific.find.page(params[:page])

    rescue

      redirect_to(reset_filterrific_url) and return

    end

  end

private

  def check_permission
    require_permission 'shift_notes', 2
  end

end