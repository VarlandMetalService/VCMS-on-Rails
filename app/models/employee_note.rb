class EmployeeNote < ActiveRecord::Base
  
  # Constants.
  VALID_IP_REGEX = /\A([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}\z/i
  
  # Pagination.
  self.per_page = 10
  
  # Associations.
  belongs_to    :subject,
                class_name: 'User',
                foreign_key: 'employee'
  belongs_to    :author,
                class_name: 'User',
                foreign_key: 'entered_by'
  
  # Validations.
  validates :subject,
            presence: true
  validates :entered_by,
            presence: true
  validates :note_on,
            presence: true
  validates :note_type,
            presence: true,
            inclusion: { in: %w(Positive Negative Neutral), message: "%{value} is not a valid type" }
  validates :ip_address,
            presence: true,
            format: { with: VALID_IP_REGEX }
  validates :notes,
            presence: true
  
  # Filtering.
  filterrific(
    default_filter_params: { sorted_by: 'note_on_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_employee,
      :with_note_type,
      :with_entered_by,
      :with_date_gte
    ]
  )
  
  # Scopes.
  scope :sorted_by, ->(sort_option) {
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^note_on/
        order "employee_notes.note_on #{direction}"
      else
        order 'employee_notes.note_on desc'
    end
  }
  scope :search_query, ->(query) {
    where 'notes like ? or follow_up like ?', "%#{query}%", "%#{query}%"   
  }  
  scope :with_employee, ->(values) {
    where employee: [*values]
  }
  scope :with_note_type, ->(values) {
    where note_type: [*values]
  }
  scope :with_entered_by, ->(values) {
    where entered_by: [*values]
  }
  scope :with_date_gte, ->(value) {
    where 'note_on >= ?', value
  }
  
  # Select options for type.
  def self.options_for_type
    [
      ['Positive', 'Positive'],
      ['Negative', 'Negative'],
      ['Neutral', 'Neutral']
    ]
  end
  
  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (oldest first)', 'note_on_asc'],
      ['Date (newest first)', 'note_on_desc']
    ]
  end
  
  # Select options for entered by.
  def self.options_for_entered_by
    users = User.where id: EmployeeNote.uniq.pluck(:entered_by)
    users.map { |u| [u.full_name, u.id] }
  end
  
  def formatted_notes
    notes.gsub(/\r\n/, '<br />')
  end
  def formatted_follow_up
    follow_up.gsub(/\r\n/, '<br />')
  end
  
end