class Attachment < ActiveRecord::Base

  # Associations.
  belongs_to      :attachable,
                  polymorphic: true

  accepts_nested_attributes_for   :attachable,
                                  reject_if: :all_blank

  # Constants.

  # Validations.

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.name = self.filename if self.name.blank?
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end
  end

private

  def sanitize_filename(filename)
    return File.basename(filename)
  end

end