require 'spec_helper'

module Encrypto
  describe Keys do

    describe ".generate_keypair" do
      it "generates a keypair" do
        public_key = double("public_key", :to_s => "hex public key")
        private_key = double("private key", :public_key => public_key)
        Crypto::PrivateKey.should_receive(:generate).and_return(private_key)
        Encrypto::Keys.generate_keypair.should eql ["hex public key", private_key]
      end
    end

  end
end
