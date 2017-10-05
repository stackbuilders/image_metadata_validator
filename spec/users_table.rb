require 'spec_helper'

RSpec.shared_context 'users table' do
  let(:validation) { nil }
  let(:attributes) { {} }
  let(:cls) do
    local_validation = validation
    User.tap do |c|
      c.clear_validators!
      c.validates :avatar, **local_validation if local_validation
    end
  end

  before do
    ActiveRecord::Schema.define(version: 1) do
      create_table :users, force: true do |t|
        t.column :avatar, :string
      end
    end
  end
end
