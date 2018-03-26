class Asset < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, FileUploader

  def image?
    file.content_type.start_with?('image') if file?
  end
  validate :id_document_file_size_validation

  def id_document_file_size_validation
    errors.add(:file, "You cannot upload a file greater than 2MB") if
        file.size > 2.megabytes
  end

end

class Asset::IdDocumentFile < Asset
end

class Asset::IdBillFile < Asset
end
