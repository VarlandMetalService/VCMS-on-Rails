class Category < ActiveRecord::Base

  # Default sorting.
  default_scope { order('parent_id ASC, position ASC, name ASC') }

  # Nested set functionality.
  acts_as_nested_set

  # Associations.
  has_and_belongs_to_many   :documents,
                            :order => 'name'

  # Callbacks.
  after_create :get_google_documents

  before_save :set_position
  def set_position
    if self.position.nil?
      self.position = 10
    end
  end

  # Validations.
  validates :name,
            presence: true,
            uniqueness: { scope: :parent_id }

  # Scopes.
  scope :top_level, -> { where(parent_id: nil) }

  def get_google_documents
    return if self.google_drive_folder.nil?
    begin
      toby = User.find_by_username('toby')
      response = RestClient.get 'https://script.google.com/macros/s/AKfycbz-J-aCcL_RRemvH6gtzWnFeCI9maGFO8ewtVDraNHy4BXa9-k/exec', params: { url: self.google_drive_folder }, accept: :json
      google_documents = JSON.parse(response)
      if google_documents.length > 0
        google_documents.each do |g|
          id = g['id']
          url = g['url']
          exist = self.documents.where(google_id: id)
          if exist.count == 0
            newDoc = Document.new
            newDoc.google_url = url
            newDoc.lookup_google_info
            newDoc.added_by = toby.id
            newDoc.save
            self.documents << newDoc
          end
        end
      end
    rescue => e
      return
    end
  end

end