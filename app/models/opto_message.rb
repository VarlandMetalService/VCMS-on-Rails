class OptoMessage < ActiveRecord::Base

  # Pagination.
  self.per_page = 50

  # Filtering.
  filterrific(
    default_filter_params: { sorted_by: 'message_at DESC' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_date_gte,
      :with_date_lte,
      :with_department,
      :with_shop_order,
      :with_customer,
      :with_load,
      :with_lane,
      :with_station,
      :with_barrel,
      :with_type,
      :without_type
    ]
  )

  # Scopes.
  scope :sorted_by, ->(sort_option) {
    order sort_option
  }
  scope :search_query, ->(query) {
    where 'message like ?', "%#{query}%"
  }
  scope :with_date_gte, ->(value) {
    timestamp = Time.zone.parse(value)
    where 'message_at >= ?', timestamp.utc
  }
  scope :with_date_lte, ->(value) {
    timestamp = Time.zone.parse(value)
    where 'message_at <= ?', timestamp.utc
  }
  scope :with_department, ->(values) {
    where department: [*values]
  }
  scope :with_shop_order, ->(values) {
    where shop_order: [*values]
  }
  scope :with_customer, ->(values) {
    where customer: [*values]
  }
  scope :with_load, ->(values) {
    where load: [*values]
  }
  scope :with_lane, ->(values) {
    where lane: [*values]
  }
  scope :with_station, ->(values) {
    where station: [*values]
  }
  scope :with_barrel, ->(values) {
    where barrel: [*values]
  }
  scope :with_type, ->(values) {
    return if values == [""]
    where message_name: [*values]
  }
  scope :without_type, ->(values) {
    return if values == [""]
    where.not message_name: [*values]
  }

  # Select options for department.
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

  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (newest first)', 'message_at DESC'],
      ['Date (oldest first)', 'message_at']
    ]
  end

  # Select options for type.
  def self.options_for_type
    OptoMessage.uniq.pluck(:message_name).sort
  end

  # Select options for barrel.
  def self.options_for_barrel
    barrels = OptoMessage.uniq.pluck(:barrel)
    barrels.compact!
    barrels.sort!
  end

  # Select options for lane.
  def self.options_for_lane
    lanes = OptoMessage.uniq.pluck(:lane)
    lanes.compact!
    lanes.sort!
  end

end