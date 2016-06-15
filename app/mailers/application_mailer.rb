class ApplicationMailer < ActionMailer::Base

  before_action :define_styles

  default from: 'varlandmetalservice@gmail.com'
  layout 'mailer'

protected

  def define_styles
    @body = 'background-color: #fff; font-family: sans-serif; font-size: 14px; color: #000;'
    @h1 = 'margin: 0; padding: 0; line-height: 1; font-size: 30px; font-weight: 500;'
    @h2 = 'margin: 1em 0 0; padding: 0; line-height: 1; font-size: 20px; font-weight: 500;'
    @code = 'color: #c7254e; background-color: #f9f2f4; font-family: Menlo, Monaco, Consolas, \'Courier New\', monospace;'
    @p = 'margin: 0 0 1em; padding: 0; line-height: 1.4;'
    @p_bold_caps = "#{@p} font-weight: bold; text-transform: uppercase; font-size: 80%;";
    @p_no_margin = 'margin: 0; padding: 0; line-height: 1.4;'
    @p_half_margin = 'margin: 0 0 0.5em; padding: 0; line-height: 1.4;'
    @well = 'margin: 0 0 1em; padding: 1em; background-color: #eeeeee; margin-top: 0.5em; border-radius: 10px;'
    @capsule = 'padding: 0.5em 1em; border-radius: 1em; font-size: 80%; font-weight: bold; font-family: Menlo, Monaco, Consolas, \'Courier New\', monospace; margin-left: 1em;'
    @uncolor = 'color: #AA9C84;'
    @clearfix = 'font-size: 0; height: 0; clear: both; display: block; border: none;'
    @hr = 'height: 1px; border-top: 1px solid #bbbbbb; background-color: #fff; margin: 1em;'
    @list_group = 'border: 1px solid #dddddd; margin: 0; border-radius: 5px; background-color: #eeeeee; list-style: none; padding: 0;'
    @list_group_li = 'margin: 0; padding: 1em; border-bottom: 1px solid #dddddd;'
    @list_group_li_bottom = 'margin: 0; padding: 1em; border-bottom: none;'
  end

end