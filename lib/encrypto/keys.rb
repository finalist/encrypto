module Encrypto
  module Keys

    def self.generate_keypair
      private_key = RbNaCl::PrivateKey.generate
      [private_key.public_key, private_key]
    end

    def self.to_bytes(key)
      key.to_bytes
    end

    def self.public_key_from_bytes(bytes)
      RbNaCl::PublicKey.new(bytes)
    end

  end
end
