module Encrypto

  def self.generate_keypair
    Keys.generate_keypair
  end

  def self.generate_random_key
    Random.bytes
  end

  def self.encrypt_with_passphrase(value, passphrase)
    passphrase_box(passphrase).box(value)
  end

  def self.decrypt_with_passphrase(cipher_text, passphrase)
    passphrase_box(passphrase).open(cipher_text)
  end

  def self.encrypt_with_keypair(value, public_key, signing_private_key)
    keypair_box(public_key, signing_private_key).box(value)
  end

  def self.decrypt_with_keypair(cipher_text, signing_public_key, private_key)
    keypair_box(signing_public_key, private_key).open(cipher_text)
  end

  private

  def self.keypair_box(public_key, private_key)
    Box.from_keypair(public_key, private_key)
  end

  def self.passphrase_box(passphrase)
    Box.from_passphrase(passphrase)
  end

end
