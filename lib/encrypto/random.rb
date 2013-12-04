module Encrypto
  module Random

    def self.bytes
      Crypto::Random.random_bytes
    end

  end
end
