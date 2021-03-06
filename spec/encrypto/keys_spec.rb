require 'spec_helper'

module Encrypto
  describe Keys do

    describe '.generate_keypair' do
      it 'generates a keypair' do
        public_key = double("public_key")
        private_key = double("private key", :public_key => public_key)
        RbNaCl::PrivateKey.should_receive(:generate).and_return(private_key)
        Keys.generate_keypair.should eql [public_key, private_key]
      end

      it 'returns a private key' do
        public_key, private_key = Keys.generate_keypair
        private_key.should be_a RbNaCl::PrivateKey
      end

      it 'returns a public key' do
        public_key, private_key = Keys.generate_keypair
        public_key.should be_a RbNaCl::PublicKey
      end
    end

    describe '.to_bytes' do
      let(:key) { 'x'*32 }

      it 'returns the bytes of the key' do
        newkey = key.b
        private_key = RbNaCl::PrivateKey.new(newkey)
        Keys.to_bytes(private_key).should eql newkey
      end
    end

    describe '.public_key_from_bytes' do
      let(:key) { 'x'*32 }

      it 'returns a public key' do
        public_key = Keys.public_key_from_bytes(key.b)
        public_key.should be_a RbNaCl::PublicKey
      end
    end

  end
end
