require 'spec_helper'

module Encrypto
  describe Encrypto do

    describe ".generate_keypair" do
      it "delegates to Keys" do
        Encrypto::Keys.should_receive(:generate_keypair)
        subject.generate_keypair
      end
    end

    describe ".generate_random_key" do
      it "delegates to Random" do
        Encrypto::Random.should_receive(:bytes)
        subject.generate_random_key
      end
    end

    describe '.encrypt_with_passphrase' do
      it 'boxes the value in a passphrase box' do
        value = double("value")
        passphrase = double("passphrase")
        box = double("box")

        Encrypto::Box.should_receive(:from_passphrase).
                    with(passphrase).
                    and_return(box)

        box.should_receive(:box).
            with(value)

        subject.encrypt_with_passphrase(value, passphrase)
      end
    end

    describe ".decrypt_with_passphrase" do
      it "opens the ciphertext with from passphrase box" do
        passphrase = double("passphrase")
        box = double("box")
        cipher_text = double("cipher text")

        Encrypto::Box.should_receive(:from_passphrase)
        .with(passphrase)
        .and_return(box)

        box.should_receive(:open).
          with(cipher_text)

        subject.decrypt_with_passphrase(cipher_text, passphrase)
      end
    end

    describe '.encrypt_with_keypair' do
      it 'boxes the value in a keypair box' do
        value = double("value")
        public_key = double("public")
        hex_public_key = double("hex_public_key")
        signing_private_key = double("signing_private_key")
        box = double("box")

        Encrypto::Keys.should_receive(:hex_public_key).
             with(public_key).
             and_return(hex_public_key)

        Encrypto::Box.should_receive(:from_keypair).
                    with(hex_public_key, signing_private_key).
                    and_return(box)

        box.should_receive(:box).
            with(value)

        subject.encrypt_with_keypair(value, public_key, signing_private_key)
      end
    end

    describe ".decrypt_with_keypair" do
      let(:cipher_text)    { double("cipher text") }
      let(:hex_public_key) { double("hex public key") }
      let(:public_key)     { double("public key") }
      let(:private_key)    { double("private key") }

      it "creates a public key" do
        Encrypto::Keys.should_receive(:hex_public_key).with(hex_public_key)
        Encrypto::Box.stub(from_keypair: double(open: nil))

        subject.decrypt_with_keypair(cipher_text, hex_public_key, private_key)
      end

      it "decrypts the cipher text with the keypair"  do
        box = double

        Encrypto::Keys.stub(hex_public_key: public_key)
        Encrypto::Box.should_receive(:from_keypair).with(public_key, private_key).and_return(box)
        box.should_receive(:open).with(cipher_text)

        subject.decrypt_with_keypair(cipher_text, hex_public_key, private_key)
      end

      it "returns the decrypted cipher text" do
        box = double(open: "decrypted value")
        Encrypto::Keys.stub(hex_public_key: public_key)
        Encrypto::Box.stub(from_keypair: box)

        subject.decrypt_with_keypair(cipher_text, hex_public_key, private_key).should eql "decrypted value"
      end
    end
  end
end
