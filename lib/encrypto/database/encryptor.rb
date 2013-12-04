module Encrypto
  module Database

    class Encryptor
      def self.encrypt(options)
        box = Box.from_secret_key(options[:key])
        box.box(options[:value])
      end

      def self.decrypt(options)
        box = Box.from_secret_key(options[:key])
        box.open(options[:value])
      end
    end

  end
end
