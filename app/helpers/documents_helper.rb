module DocumentsHelper

  def content_type_icon type
    case type
      when 'image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/tiff'
        '<i class="fa fa-fw fa-file-image-o text-info"></i>'.html_safe
      when 'video/quicktime', 'video/mp4'
        '<i class="fa fa-fw fa-file-video-o text-info"></i>'.html_safe
      when 'google/spreadsheets'
        '<i class="fa fa-fw fa-file-excel-o text-success"></i>'.html_safe
      when 'application/pdf'
        '<i class="fa fa-fw fa-file-pdf-o text-danger"></i>'.html_safe
      when 'google/document'
        '<i class="fa fa-fw fa-file-word-o text-info"></i>'.html_safe
      else
        '<i class="fa fa-fw fa-file"></i>'.html_safe
    end
  end

  def category_list cat

    if cat.children.length == 0 && cat.documents.length == 0
      return ''.html_safe
    end

    item = "<div class=\"panel panel-default\"><div class=\"panel-heading\"><h3 class=\"panel-title\" data-toggle=\"collapse\" data-target=\".cat#{cat.id}\" style=\"cursor: pointer;\"><i class=\"fa fa-fw fa-folder\" aria-hidden=\"true\"></i> #{cat.name}</h3></div>"
    if cat.children.length > 0
      item += "<div class=\"panel-body collapse cat#{cat.id}\">"
      cat.children.each do |child|
        item += category_list(child)
      end
      item += "</div>"
    end
    if cat.documents.length > 0
      item += "<div class=\"list-group collapse cat#{cat.id}\">"
      cat.documents.order(document_updated_at: :desc).each do |doc|
        extra_info = ' <small class="text-muted">' + doc.document_updated_at.strftime('%m/%d/%y') + '</small>'
        item += link_to(content_type_icon(doc.content_type) + ' ' + doc.name + extra_info.html_safe, doc, :class => 'list-group-item')
      end
      item += "</div>"
    end
    item += "</div>"

    item.html_safe

  end

end