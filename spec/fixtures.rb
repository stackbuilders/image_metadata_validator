module SpecHelpers
  module Fixtures
    def image_with_size(size)
      File.open(File.expand_path("spec/resources/images/avatar_#{size}.jpeg"))
    end
  end
end
