require 'spec_helper'

RSpec.describe ImageMetadataValidator do
  it 'has a version number' do
    expect(ImageMetadataValidator::VERSION).not_to be_nil
  end
end
