require 'rest-client'

class Document < ActiveRecord::Base

  # Pagination.
  self.per_page = 100

  # CarrierWave uploader support.
  mount_uploader  :file,
                  FileUploader

  # Associations.
  has_and_belongs_to_many   :categories
  belongs_to                :user,
                            foreign_key: 'added_by'

  accepts_nested_attributes_for   :categories,
                                  reject_if: :all_blank,
                                  allow_destroy: false

  # Validations.
  validates :name,
            presence: true
  validates :user,
            presence: true
  validates :content_type,
            presence: true

  # Filtering.
  filterrific(
    default_filter_params: { sorted_by: 'document_updated_at DESC' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_category
    ]
  )

  before_save :set_doc_update
  def set_doc_update
    self.document_updated_at = Time.new
  end
  def lookup_google_info(email=false)
    return if self.google_url.nil?
    begin
      response = RestClient.get 'https://script.google.com/macros/s/AKfycbxXLu_t6lEyYUpLQ3s5tcfQz-691nGEuOV-eK7tce5uTmcbToM/exec', params: { url: self.google_url }, accept: :json
      parsed = JSON.parse(response)
      if parsed['valid']
        self.content_type = "google/#{parsed['type']}"
        self.google_id = parsed['id']
        self.google_contents = parsed['contents']
        self.name = parsed['title']
        self.google_updated_at = Time.new
        self.is_valid = true
      else
        self.is_valid = false
      end
    rescue => e
      self.is_valid = false
    end
  end

  # Scopes.
  scope :sorted_by, ->(sort_option) {
    order sort_option
  }
  scope :search_query, ->(query) {
    where 'documents.name like ? or google_contents like ?', "%#{query}%", "%#{query}%"
  }
  scope :with_category, ->(values) {
    return if values == [""]
    joins(:categories).where(categories: { id: values })
  }

  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (newest first)', 'document_updated_at DESC'],
      ['Date (oldest first)', 'document_updated_at']
    ]
  end

  # Select options for category.
  #def self.options_for_category
  #  categories = Category.find_by_depth 0
  #  options = []
  #  categories.each do |c|
  #    options.push [c.name, c.id]
  #  end
  #end

  def initialize(params = {})
    super
    self.is_valid = true
  end

end