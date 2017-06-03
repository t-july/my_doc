require 'xsd_reader'

class TemplateService
  attr_reader :reader

  def initialize
  end

  def load_xsd(xsd_file)
    @reader = XsdReader::XML.new(xsd_xml: xml_content(xsd_file))
    reader.logger.level = Logger::DEBUG

    # puts reader.xml
    # ap reader.schema

    # ap reader.elements
    # ap reader.elements
    # ap reader.simple_types
    # ap reader.imports
    # ap reader.elements.map(&:name)
    # ap reader['Файл']
    reader.elements.each do |element|
      ap element.class
      ap element.name
      ap element.type
      ap element.complex_type.class
      element.complex_type.all_elements.each do |el|
        ap el.name
      end
    end

  end

  def run(xsd_file, xml_file)
    xsd = Nokogiri::XML::Schema(xml_content(xsd_file))
    doc = Nokogiri::XML(xml_content(xml_file))

    xsd.validate(doc).each do |error|
      puts error.message
    end
  end

  # Изменить кодировку windows в юникод
  def xml_content(file)
    data = File.read(file)
    # data.encode 'UTF-8', 'CP1251'
  end
end
