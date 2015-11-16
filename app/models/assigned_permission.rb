class AssignedPermission < ActiveRecord::Base
  
  # Associations.
  belongs_to      :user
  belongs_to      :permission
  
  accepts_nested_attributes_for   :permission,
                                  reject_if: :all_blank
  accepts_nested_attributes_for   :user,
                                  reject_if: :all_blank
  
  # Select options for value.
  def self.options_for_value
    [
      ['No Access', '0'],
      ['Read-Only', '1'],
      ['Edit', '2'],
      ['Admin', '3']
    ]
  end
  
end