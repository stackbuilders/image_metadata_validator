require 'spec_helper'

RSpec.describe ImageMetadataValidator do
  before do
    ActiveRecord::Schema.define(version: 1) do
      create_table :users, force: true do |t|
        t.column :avatar, :string
      end
    end
  end

  context 'user' do
    let(:user) { User.new }

    it "should not allow nil as url" do
      user.avatar = File.join(File.dirname(__FILE__), '../resources/avatar_woman.jpeg')
      expect(user).not_to be_valid
    end
  end

  it 'has a version number' do
    expect(ImageMetadataValidator::VERSION).not_to be_nil
  end
end
