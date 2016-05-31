class ShiftNote < ActiveRecord::Base

  # Constants.
  VALID_IP_REGEX = /\A([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}\z/i

  # Pagination.
  self.per_page = 50

  # Associations.
  belongs_to    :author,
                class_name: 'User',
                foreign_key: 'entered_by'
  has_many      :attachments,
                as: :attachable,
                dependent: :destroy

  accepts_nested_attributes_for   :attachments,
                                  reject_if: :all_blank,
                                  allow_destroy: true

  # Validations.
  validates :entered_by,
            presence: true
  validates :note_on,
            presence: true
  validates :shift,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :ip_address,
            presence: true,
            format: { with: VALID_IP_REGEX }
  validates :department,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 30 },
            allow_nil: true,
            allow_blank: true
  validates :note_type,
            inclusion: { in: %w(Lab Maintenance IT Plating), message: "%{value} is not a valid type" },
            allow_nil: true,
            allow_blank: true
  validates :notes,
            presence: true

  # Filtering.
  filterrific(
    default_filter_params: { sorted_by: 'note_on DESC, shift DESC' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_note_type,
      :with_entered_by,
      :with_date,
      :with_shift,
      :with_department
    ]
  )

  # Scopes.
  scope :sorted_by, ->(sort_option) {
    order sort_option
  }
  scope :search_query, ->(query) {
    where 'notes like ?', "%#{query}%"
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
  scope :with_date_lte, ->(value) {
    where 'note_on <= ?', value
  }
  scope :with_date, ->(value) {
    where 'note_on = ?', value
  }
  scope :with_shift, ->(values) {
    where shift: [*values]
  }
  scope :with_department, ->(values) {
    where department: [*values]
  }

  # Select options for type.
  def self.options_for_type
    [
      ['IT', 'IT'],
      ['Lab', 'Lab'],
      ['Maintenance', 'Maintenance'],
      ['Plating', 'Plating']
    ]
  end

  # Select options for type.
  def self.options_for_department
    [
      ['Dept. 3', '3'],
      ['Dept. 4', '4'],
      ['Dept. 5', '5'],
      ['Dept. 6', '6'],
      ['Dept. 7', '7'],
      ['Dept. 8', '8'],
      ['Dept. 10', '10'],
      ['Dept. 12', '12'],
      ['Waste Water', '30']
    ]
  end

  # Select options for shift.
  def self.options_for_shift
    [
      ['1', '1'],
      ['2', '2'],
      ['3', '3']
    ]
  end

  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (oldest first)', 'note_on, shift'],
      ['Date (newest first)', 'note_on DESC, shift DESC']
    ]
  end

  # Select options for entered by.
  def self.options_for_entered_by
    users = User.where id: ShiftNote.uniq.pluck(:entered_by)
    users.map { |u| [u.full_name, u.id] }
  end

  def formatted_notes
    notes.gsub(/\r\n/, '<br />').html_safe
  end

  def initialize(params = {})
    super
    current_time = Time.new
    today = Date.today
    case current_time.hour
      when 0..6
        self.shift = 3
        self.note_on = today - 1
      when 7..14
        self.shift = 1
        self.note_on = today
      when 13..22
        self.shift = 2
        self.note_on = today
      when 23
        self.shift = 3
        self.note_on = today
    end
  end

end