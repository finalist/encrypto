module Encrypto
  module Random

    def self.bytes
      RbNaCl::Random.random_bytes
    end

  end
end
