class AttachmentsController < ApplicationController

  def show
    @attachment = Attachment.find params[:id]
    send_data(@attachment.file_contents,
              type: @attachment.content_type,
              filename: @attachment.name,
              disposition: 'inline')
  end

end