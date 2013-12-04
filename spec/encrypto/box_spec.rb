require 'spec_helper'

module Encrypto
  describe Box do

    describe '.from_passphrase' do
      let(:passphrase) { 'password' }

      it 'hashes the secret key' do
        Crypto::Hash.should_receive(:sha256).with(passphrase)
        Crypto::RandomNonceBox.stub(:from_secret_key)
        Encrypto::Box.from_passphrase(passphrase)
      end

      it 'creates a random nonce box based on the hashed secret key' do
        Crypto::Hash.stub(:sha256 => "sha")
        Crypto::RandomNonceBox.should_receive(:from_secret_key).with("sha")
        Encrypto::Box.from_passphrase(passphrase)
      end

      it 'initializes with a random nonce box' do
        box = double("box")
        Crypto::Hash.stub(:sha256 => "sha")
        Crypto::RandomNonceBox.stub(:from_secret_key => box)
        Encrypto::Box.should_receive(:new).with(box)
        Encrypto::Box.from_passphrase(passphrase)
      end
    end

    describe ".from_keypair" do
      let(:public_key)  { double("public key") }
      let(:private_key) { double("private key") }

      it "creates a random nonce box based on the keypair" do
        Crypto::RandomNonceBox.should_receive(:from_keypair).with(public_key, private_key)
        Encrypto::Box.from_keypair(public_key, private_key)
      end

      it "initializes with a random nonce box" do
        box = double("box")
        Crypto::RandomNonceBox.stub(:from_keypair => box)
        Encrypto::Box.should_receive(:new).with(box)
        Encrypto::Box.from_keypair(public_key, private_key)
      end
    end

    describe '#box' do
      it 'boxes the value' do
        value = double("value")

        some_box = double("box")
        some_box.should_receive(:box).with(value, :hex)

        box = Encrypto::Box.new(some_box)
        box.box(value)
      end
    end

    describe "#open" do
      it "opens the cipher text" do
        cipher_text = double("cipher text")

        some_box = double("box")
        some_box.should_receive(:open).with(cipher_text, :hex)

        box = Encrypto::Box.new(some_box)
        box.open(cipher_text)
      end
    end

  end
end
