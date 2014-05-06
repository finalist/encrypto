module Encrypto

  class Box
    def initialize(nacl_box)
      @nacl_box = nacl_box
    end

    def box(value)
      @nacl_box.box(value)
    end

    def open(cipher_text)
      @nacl_box.open(cipher_text)
    end

    def self.from_passphrase(passphrase)
      passphrase_sha = RbNaCl::Hash.sha256(passphrase)
      from_secret_key(passphrase_sha)
    end

    def self.from_secret_key(secret_key)
      new(RbNaCl::SimpleBox.from_secret_key(secret_key.b))
    end

    def self.from_keypair(public_key, private_key)
      new(RbNaCl::SimpleBox.from_keypair(public_key, private_key))
    end

  end
end
