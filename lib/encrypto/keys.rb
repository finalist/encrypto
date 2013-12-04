module Encrypto
  module Keys

    def self.generate_keypair
      private_key = Crypto::PrivateKey.generate
      [private_key.public_key.to_s(:hex), private_key]
    end

    def self.hex_public_key(value)
      Crypto::PublicKey.new(value, :hex)
    end

  end
end
