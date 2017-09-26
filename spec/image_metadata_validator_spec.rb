require 'spec_helper'

RSpec.describe ImageMetadataValidator do
  before do
    ActiveRecord::Schema.define(version: 1) do
      create_table :users, force: true do |t|
        t.column :avatar, :string
        t.column :avatar_greater, :string
        t.column :avatar_greater_or_equal, :string
        t.column :avatar_equal, :string
        t.column :avatar_less, :string
        t.column :avatar_less_or_equal, :string
      end
    end
  end

  it 'has a version number' do
    expect(ImageMetadataValidator::VERSION).not_to be_nil
  end

  context 'width validation' do
    subject { User.new(attributes) }

    describe 'greater_than option' do
      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar_greater: image_with_size(300) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar_greater: image_with_size(200) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar_greater: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'greater_than_or_equal_to option' do
      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar_greater_or_equal: image_with_size(300) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar_greater_or_equal: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar_greater_or_equal: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'equal_to option' do
      context 'when width equals the validation option' do
        let (:attributes) { { avatar_equal: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar_equal: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar_equal: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'less_than option' do
      context 'when width is less than the validation option' do
        let (:attributes) { { avatar_less: image_with_size(100) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar_less: image_with_size(200) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar_less: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'less_than_or_equal_to option' do
      context 'when width is less than the validation option' do
        let (:attributes) { { avatar_less_or_equal: image_with_size(100) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar_less_or_equal: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar_less_or_equal: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end
  end

  private

  def image_with_size(size)
    File.open(File.expand_path("spec/resources/images/avatar_#{size}.jpeg"))
  end
end
