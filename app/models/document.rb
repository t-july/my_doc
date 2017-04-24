class Document < ActiveRecord::Base
  belongs_to :user

  validates :user, :name, :schema_file, presence: true

  attr_accessor :schema_file_upload

  before_validation do
    if schema_file_upload
      # Store file content
      self.schema_file = schema_file_upload.read
    end
  end

  # Windows кодировка XML файла
  def schema_file_content
    if schema_file.present?
      schema_file.encode('UTF-8', 'CP1251')
    end
  rescue
    begin
      # Detect text encoding, convert to unicode
      cd = CharDet.detect(schema_file)
      schema_file.encode('UTF-8', cd['encoding'])
    rescue
      'Неизвестная кодировка'
    end
  end
end
