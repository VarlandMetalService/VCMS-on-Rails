class ThicknessCheck < ActiveRecord::Base

  # Default scoping.
  default_scope { where 'is_deleted IS FALSE' }

  # Associations.
  belongs_to    :thickness_block

end