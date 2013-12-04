require 'spec_helper'

module Encrypto
  describe Random

  describe ".bytes" do
    it "creates a random byte sequence" do
      random_bytes = "asf2020fasd"
      RbNaCl::Random.should_receive(:random_bytes).and_return(random_bytes)
      Encrypto::Random.bytes.should eql random_bytes
    end
  end

end
