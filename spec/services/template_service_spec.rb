require 'rails_helper'

RSpec.describe TemplateService do
  let(:xsd1) { Rails.root.join('spec/fixtures', 'NO_NDFL3_1_033_00_05_10_03.xsd') }
  let(:xml1) { Rails.root.join('spec/fixtures', 'NO_NDFL3_7727_7727_143514475535_20170219_9443D582-23DF-4E39-94A7-19FE8F3C9089.xml') }

  subject do
    TemplateService.new
  end

  it 'subject' do
    expect(subject).to be_a described_class
  end

  it '#load_xsd' do
    subject.load_xsd(xsd1)
  end

  it 'run' do
    subject.run(xsd1, xml1)
  end

  it 'traverse' do
    doc = Nokogiri::XML(xsd1.read)

    doc.xpath('.//xs:element').each do |node|
      puts node.name
      puts node[:name]

      ap node.xpath('./xs:annotation/xs:documentation').text
    end

    # ap doc.root.class
    # doc.root.traverse.each do |node|
    #   puts node.type
    # end
  end

  it '#xml_content' do
    res = subject.xml_content(xsd1)
    puts res
    puts res.encoding
  end
end
