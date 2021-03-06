class Attachment < ActiveRecord::Base

  # CarrierWave uploader support.
  mount_uploader  :file,
                  FileUploader

  # Associations.
  belongs_to      :attachable,
                  polymorphic: true

  accepts_nested_attributes_for   :attachable,
                                  reject_if: :all_blank

  # Constants.

  # Validations.

end