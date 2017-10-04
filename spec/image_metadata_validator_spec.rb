require 'spec_helper'

RSpec.describe ImageMetadataValidator do
  it 'has a version number' do
    expect(ImageMetadataValidator::VERSION).not_to be_nil
  end

  context 'abstract validator' do
    include_context 'users table'

    let(:attributes) { { avatar: image_with_size(300) } }
    let(:validation) { { image_metadata_base: { greater_than: 30 } } }
    subject { -> { cls.new(attributes) }.call }

    it 'raises an error when trying to use the base validator' do
      expect { subject.valid? }.to raise_error NotImplementedError
    end
  end

  private

  def image_with_size(size)
    File.open(File.expand_path("spec/resources/images/avatar_#{size}.jpeg"))
  end
end
