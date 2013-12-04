require 'spec_helper'

module Encrypto
  module Database

    describe Encryptor do

      describe ".encrypt" do

        it "creates a symmetric box based on the key" do
          box = double("box").as_null_object
          Box.should_receive(:from_secret_key).with("key").and_return(box)

          Encryptor.encrypt({:value => "value", :key => "key"})
        end

        it "boxes the value" do
          box = double("box")
          Box.stub(:from_secret_key).and_return(box)

          box.should_receive(:box).with("value")

          Encryptor.encrypt({:value => "value", :key => "key"})
        end

      end

      describe ".decrypt" do

        it "creates a symmetric box based on the key" do
          box = double("box").as_null_object
          Box.should_receive(:from_secret_key).with("key").and_return(box)

          Encryptor.decrypt({:value => "value", :key => "key"})
        end

        it "opens the value" do
          box = double("box")
          Box.stub(:from_secret_key).and_return(box)

          box.should_receive(:open).with("value")

          Encryptor.decrypt({:value => "value", :key => "key"})
        end

      end
    end
  end
end
