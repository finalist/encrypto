require 'spec_helper'

module Encrypto
  describe Box do

    describe '.from_passphrase' do
      let(:passphrase) { 'password' }

      it 'hashes the secret key' do
        RbNaCl::Hash.should_receive(:sha256).with(passphrase)
        RbNaCl::RandomNonceBox.stub(:from_secret_key)
        Box.from_passphrase(passphrase)
      end

      it 'creates a random nonce box based on the hashed secret key' do
        RbNaCl::Hash.stub(:sha256 => 'sha')
        RbNaCl::RandomNonceBox.should_receive(:from_secret_key).with('sha')
        Box.from_passphrase(passphrase)
      end

      it 'initializes with a random nonce box' do
        box = double('box')
        RbNaCl::Hash.stub(:sha256 => 'sha')
        RbNaCl::RandomNonceBox.stub(:from_secret_key => box)
        Box.should_receive(:new).with(box)
        Box.from_passphrase(passphrase)
      end
    end

    describe '.from_keypair' do
      let(:public_key)  { double('public key') }
      let(:private_key) { double('private key') }

      it 'creates a random nonce box based on the keypair' do
        RbNaCl::RandomNonceBox.should_receive(:from_keypair).with(public_key, private_key)
        Box.from_keypair(public_key, private_key)
      end

      it 'initializes with a random nonce box' do
        box = double('box')
        RbNaCl::RandomNonceBox.stub(:from_keypair => box)
        Box.should_receive(:new).with(box)
        Box.from_keypair(public_key, private_key)
      end
    end

    describe '#box' do
      it 'boxes the value' do
        value = double('value')

        some_box = double('box')
        some_box.should_receive(:box).with(value)

        box = Box.new(some_box)
        box.box(value)
      end
    end

    describe '#open' do
      it 'opens the cipher text' do
        cipher_text = double('cipher text')
        cipher_text.stub(:clone => cipher_text)

        some_box = double('box')
        some_box.should_receive(:open).with(cipher_text)

        box = Box.new(some_box)
        box.open(cipher_text)
      end
    end

  end
end
