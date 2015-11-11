class AssignedPermission < ActiveRecord::Base
  
  # Associations.
  belongs_to      :user
  belongs_to      :permission
  
end