require 'spec_helper'

module Encrypto
  describe Encrypto do

    describe '.generate_keypair' do
      it 'delegates to Keys' do
        Keys.should_receive(:generate_keypair)
        subject.generate_keypair
      end
    end

    describe '.generate_random_key' do
      it 'delegates to Random' do
        Random.should_receive(:bytes)
        subject.generate_random_key
      end
    end

    describe '.encrypt_with_passphrase' do
      it 'boxes the value in a passphrase box' do
        value = double('value')
        passphrase = double('passphrase')
        box = double('box')

        Box.should_receive(:from_passphrase).
                    with(passphrase).
                    and_return(box)

        box.should_receive(:box).
            with(value)

        subject.encrypt_with_passphrase(value, passphrase)
      end

      it 'returns a cipher text' do
        subject.encrypt_with_passphrase('value', 'passphrase').should be_a String
      end
    end

    describe '.decrypt_with_passphrase' do
      it 'opens the ciphertext with from passphrase box' do
        passphrase = double('passphrase')
        box = double('box')
        cipher_text = double('cipher text')

        Box.should_receive(:from_passphrase)
        .with(passphrase)
        .and_return(box)

        box.should_receive(:open).
          with(cipher_text)

        subject.decrypt_with_passphrase(cipher_text, passphrase)
      end

      it 'decrypts a cipher text' do
        cipher_text = subject.encrypt_with_passphrase('value', 'passphrase')
        subject.decrypt_with_passphrase(cipher_text, 'passphrase').should eql 'value'
      end
    end

    describe '.encrypt_with_keypair' do
      it 'boxes the value in a keypair box' do
        value = double('value')
        public_key = double('public_key')
        signing_private_key = double('signing_private_key')
        box = double('box')

        Box.should_receive(:from_keypair).
                    with(public_key, signing_private_key).
                    and_return(box)

        box.should_receive(:box).
            with(value)

        subject.encrypt_with_keypair(value, public_key, signing_private_key)
      end

      it 'returns a cipher text' do
        public_key, private_key = Keys.generate_keypair
        subject.encrypt_with_keypair('value', public_key, private_key).should be_a String
      end
    end

    describe '.decrypt_with_keypair' do
      let(:cipher_text)    { double('cipher text') }
      let(:public_key)     { double('public key') }
      let(:private_key)    { double('private key') }

      it 'decrypts the cipher text with the keypair'  do
        box = double

        Box.should_receive(:from_keypair).with(public_key, private_key).and_return(box)
        box.should_receive(:open).with(cipher_text)

        subject.decrypt_with_keypair(cipher_text, public_key, private_key)
      end

      it 'returns the decrypted cipher text' do
        public_key, private_key = Keys.generate_keypair
        cipher_text = subject.encrypt_with_keypair('value', public_key, private_key)

        subject.decrypt_with_keypair(cipher_text, public_key, private_key).should eql 'value'
      end
    end
  end
end
