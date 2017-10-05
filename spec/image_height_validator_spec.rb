require 'spec_helper'
require_relative 'image_metadata_validator_child'

RSpec.describe 'Height validator' do
  it_behaves_like 'child of metadata base validator', 'height'
end
