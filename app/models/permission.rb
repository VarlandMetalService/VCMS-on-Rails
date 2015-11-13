class Permission < ActiveRecord::Base
  
  # Associations.
  has_many      :assigned_permissions
  has_many      :users,
                -> { select('users.*, assigned_permissions.value AS access_level') },
                :through => :assigned_permissions
  
end