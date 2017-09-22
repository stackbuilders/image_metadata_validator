require 'spec_helper'

RSpec.describe ImageMetadataValidator do
  before do
    ActiveRecord::Schema.define(version: 1) do
      create_table :users, force: true do |t|
        t.column :avatar, :string
      end
    end
  end

  context 'width validation' do
    subject { User.new(avatar: small_image) }
    it { is_expected.to be_valid }
  end

  it 'has a version number' do
    expect(ImageMetadataValidator::VERSION).not_to be_nil
  end

  private

  def small_image
    File.open(File.expand_path('spec/resources/avatar_woman.jpeg'))
  end
end
