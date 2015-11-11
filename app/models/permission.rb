class Permission < ActiveRecord::Base
  
  # Associations.
  has_many      :assigned_permissions
  has_many      :users,
                :through => :assigned_permissions
  
end