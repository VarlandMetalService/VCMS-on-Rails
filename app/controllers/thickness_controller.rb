class ThicknessController < ApplicationController

  before_action :check_user_permission

  def index

    begin

      @filterrific = initialize_filterrific(
        ThicknessBlock,
        params[:filterrific],
        select_options: {
          sorted_by: ThicknessBlock.options_for_sorted_by,
          customer: ThicknessBlock.options_for_customer,
          process: ThicknessBlock.options_for_process,
          part: ThicknessBlock.options_for_part,
          sub: ThicknessBlock.options_for_sub,
          directory: ThicknessBlock.options_for_directory,
          product: ThicknessBlock.options_for_product,
          application: ThicknessBlock.options_for_application,
          shop_order: ThicknessBlock.options_for_shop_order
        }
      ) or return

      @thickness_blocks = @filterrific.find.page(params[:page])

    rescue

      redirect_to(reset_filterrific_url) and return

    end

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ThicknessBlock.csv_header + "\n" + @thickness_blocks.map(&:to_csv).join("\n"), filename: "thickness_checks-#{Date.today}.csv" }
    end

  end

private

  def check_user_permission
    check_permission 'thickness_checks'
  end

end