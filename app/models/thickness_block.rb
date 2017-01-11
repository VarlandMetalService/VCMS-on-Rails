class ThicknessBlock < ActiveRecord::Base

  # Pagination.
  self.per_page = 100

  # Associations.
  belongs_to    :user
  has_many      :thickness_checks

  # Filtering.
  filterrific(
    default_filter_params: { sorted_by: 'block_at DESC' },
    available_filters: [
      :sorted_by,
      :with_customer,
      :with_process,
      :with_part,
      :with_sub,
      :with_directory,
      :with_product,
      :with_application,
      :with_shop_order,
      :with_date_gte,
      :with_date_lte
    ]
  )

  # Scopes.
  scope :sorted_by, ->(sort_option) {
    order sort_option
  }
  scope :with_customer, ->(values) {
    where customer: [*values]
  }
  scope :with_process, ->(values) {
    where process: [*values]
  }
  scope :with_part, ->(values) {
    where part: [*values]
  }
  scope :with_sub, ->(values) {
    where sub: [*values]
  }
  scope :with_directory, ->(values) {
    where directory: [*values]
  }
  scope :with_product, ->(values) {
    where product: [*values]
  }
  scope :with_application, ->(values) {
    where application: [*values]
  }
  scope :with_shop_order, ->(values) {
    where shop_order: [*values]
  }
  scope :with_date_gte, ->(value) {
    where 'DATE(block_at) >= ?', value
  }
  scope :with_date_lte, ->(value) {
    where 'DATE(block_at) <= ?', value
  }

  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (newest first)', 'block_at DESC'],
      ['Date (oldest first)', 'block_at']
    ]
  end

  # Select options for customer.
  def self.options_for_customer
    ThicknessBlock.uniq.pluck(:customer)
  end
  def self.options_for_process
    ThicknessBlock.uniq.pluck(:process)
  end
  def self.options_for_part
    ThicknessBlock.uniq.pluck(:part)
  end
  def self.options_for_sub
    ThicknessBlock.uniq.pluck(:sub)
  end
  def self.options_for_directory
    ThicknessBlock.uniq.pluck(:directory)
  end
  def self.options_for_product
    ThicknessBlock.uniq.pluck(:product)
  end
  def self.options_for_application
    ThicknessBlock.uniq.pluck(:application)
  end
  def self.options_for_shop_order
    ThicknessBlock.uniq.pluck(:shop_order)
  end

end