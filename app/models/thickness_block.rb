require 'rest-client'

class ThicknessBlock < ActiveRecord::Base

  # Default scoping.
  default_scope { where 'is_deleted IS FALSE AND user_id IS NOT NULL' }

  # Pagination.
  self.per_page = 25

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
    ThicknessBlock.uniq.pluck(:customer).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_process
    ThicknessBlock.uniq.pluck(:process).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_part
    ThicknessBlock.uniq.pluck(:part).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_sub
    ThicknessBlock.uniq.pluck(:sub).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_directory
    ThicknessBlock.uniq.pluck(:directory).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_product
    ThicknessBlock.uniq.pluck(:product).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_application
    ThicknessBlock.uniq.pluck(:application).sort_by {|word| word.strip.downcase}
  end
  def self.options_for_shop_order
    ThicknessBlock.uniq.pluck(:shop_order).sort!
  end

  def block_area
    if self.pounds.nil? or self.piece_weight.nil? or self.part_area.nil?
      nil
    else
      (self.pounds / self.piece_weight) * self.part_area
    end
  end

  def block_volume
    if self.pounds.nil? or self.pounds_per_cubic.nil?
      nil
    else
      (self.pounds / self.pounds_per_cubic)
    end
  end

  def self.csv_header
    fields = []
    fields.push 'Date'
    fields.push 'Time'
    fields.push 'Employee #'
    fields.push 'Customer'
    fields.push 'Process Code'
    fields.push 'Part ID'
    fields.push 'Sub ID'
    fields.push 'S.O. #'
    fields.push 'Load #'
    fields.push 'Load Weight'
    fields.push 'Piece Weight'
    fields.push 'Area (ft²)'
    fields.push 'Area (ft³)'
    fields.push 'Thickness'
    fields.push 'Alloy %'
    fields.push 'Directory'
    fields.push 'Product'
    fields.push 'Application'
    return fields.join(',')
  end

  def to_csv
    lines = []
    self.thickness_checks.each do |c|
      fields = []
      fields.push c.check_at.strftime '%m/%d/%y'
      fields.push c.check_at.strftime '%H:%M:%S'
      fields.push self.user.employee_number
      fields.push self.customer
      fields.push self.process
      fields.push self.part
      fields.push self.sub
      fields.push self.shop_order
      fields.push self.load
      fields.push self.pounds
      fields.push self.piece_weight
      fields.push self.block_area
      fields.push self.block_volume
      fields.push c.thickness
      fields.push c.alloy_percentage
      fields.push self.directory
      fields.push self.product
      fields.push self.application
      lines.push fields.join(',')
    end
    return lines.join("\n")
  end

  def standard_deviation_thickness
    return 0 if self.thickness_checks.size == 0
    return standard_deviation(self.thickness_checks.map(&:thickness))
  end

  def standard_deviation_alloy_percentage
    return 0 if self.thickness_checks.size == 0
    return 0 if self.thickness_checks.maximum(:alloy_percentage) == 0
    return standard_deviation(self.thickness_checks.map(&:alloy_percentage))
  end

  def pdf_link
    "http://so.varland.com/so/#{self.shop_order}.pdf"
  end

  def has_pdf?
    begin
      response = RestClient.get self.pdf_link
      if response.code == 200
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

end