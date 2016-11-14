class Category < ActiveRecord::Base

  # Default sorting.
  default_scope { order('parent_id ASC, position ASC, name ASC') }

  # Nested set functionality.
  acts_as_nested_set

  # Associations.
  has_and_belongs_to_many   :documents,
                            :order => 'name'

  # Validations.
  validates :name,
            presence: true,
            uniqueness: { scope: :parent_id }

  # Scopes.
  scope :top_level, -> { where(parent_id: nil) }

end