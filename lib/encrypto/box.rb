module Encrypto

  class Box
    def initialize(nacl_box)
      @nacl_box = nacl_box
    end

    def box(value)
      @nacl_box.box(value)
    end

    #
    # The cipher text is cloned. Otherwise the nonce is removed from the cipher
    # text in memory. It is possible that the same nonce and cipher text
    # are decrypted multiple times. But NEVER encrypt with the same nonce to
    # prevent replay attacks. This is prevented by using the RandomNonceBox.
    # See: https://github.com/cryptosphere/rbnacl/wiki/Secret-Key-Encryption
    #
    def open(cipher_text)
      @nacl_box.open(cipher_text.clone)
    end

    def self.from_passphrase(passphrase)
      passphrase_sha = RbNaCl::Hash.sha256(passphrase)
      from_secret_key(passphrase_sha)
    end

    def self.from_secret_key(secret_key)
      new(RbNaCl::RandomNonceBox.from_secret_key(secret_key))
    end

    def self.from_keypair(public_key, private_key)
      new(RbNaCl::RandomNonceBox.from_keypair(public_key, private_key))
    end

  end
end
