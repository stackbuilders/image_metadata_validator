require 'spec_helper'
require_relative 'users_table'

RSpec.shared_examples 'child of metadata base validator' do |dimension|
  include_context 'users table'

  let(:validator) { :"image_#{dimension}" }

  context 'initialization' do
    let(:attributes) { { avatar: image_with_size(300) } }
    subject { -> { cls.new(attributes) } }

    context 'when sending wrong validation parameter types' do
      let(:validation) { { validator => { greater_than: 'hello' } } }
      it { is_expected.to raise_error ArgumentError }
    end

    context 'when sending wrong validation option' do
      let(:validation) { { validator => { not_an_option: 200 } } }
      it { is_expected.to raise_error ArgumentError }
    end

    context 'when sending the expected parameter and option' do
      let(:validation) { { validator => { greater_than: 30 } } }
      it { is_expected.not_to raise_error }
    end
  end

  context 'width validator' do
    subject { -> { cls.new(attributes) }.call }

    describe 'greater_than option' do
      let(:validation) { { validator => { greater_than: 200 } } }

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar: image_with_size(300) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar: image_with_size(200) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'greater_than_or_equal_to option' do
      let(:validation) { { validator => { greater_than_or_equal_to: 200 } } }

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar: image_with_size(300) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'equal_to option' do
      let(:validation) { { validator => { equal_to: 200 } } }

      context 'when width equals the validation option' do
        let (:attributes) { { avatar: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar: image_with_size(100) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'less_than option' do
      let(:validation) { { validator => { less_than: 200 } } }

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar: image_with_size(100) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar: image_with_size(200) } }
        it { is_expected.not_to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'less_than_or_equal_to option' do
      let(:validation) { { validator => { less_than_or_equal_to: 200 } } }

      context 'when width is less than the validation option' do
        let (:attributes) { { avatar: image_with_size(100) } }
        it { is_expected.to be_valid }
      end

      context 'when width is equal to the validation option' do
        let (:attributes) { { avatar: image_with_size(200) } }
        it { is_expected.to be_valid }
      end

      context 'when width is greater than the validation option' do
        let (:attributes) { { avatar: image_with_size(300) } }
        it { is_expected.not_to be_valid }
      end
    end

    context 'when validation fails' do
      let(:validation) { { validator => { greater_than: 200 } } }
      let(:attributes) { { avatar: image_with_size(100) } }
      before { subject.valid? }

      it 'sets the correct error message' do
        expect(subject.errors.count).to eq 1
        expect(subject.errors.messages[:avatar])
          .to eq ["has an invalid #{dimension}"]
      end
    end
  end

  describe 'combining options' do
    subject { -> { cls.new(attributes) }.call }
    let(:validation) { { validator => { greater_than: 150, less_than: 250 } } }

    context 'when width is between expected values' do
      let (:attributes) { { avatar: image_with_size(200) } }
      it { is_expected.to be_valid }
    end

    context 'when width is less than the validation option' do
      let (:attributes) { { avatar: image_with_size(100) } }
      it { is_expected.not_to be_valid }
    end

    context 'when width is greater than the validation option' do
      let (:attributes) { { avatar: image_with_size(300) } }
      it { is_expected.not_to be_valid }
    end
  end

  private

  def image_with_size(size)
    File.open(File.expand_path("spec/resources/images/avatar_#{size}.jpeg"))
  end
end
