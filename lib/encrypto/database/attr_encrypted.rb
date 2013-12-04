module Encrypto
  module Database
    module AttrEncrypted

      def self.included(model)
        model.class_eval do
          attr_encrypted_options.merge!(
            :encryptor => ::Encrypto::Database::Encryptor,
            :key => :encryption_key,
            :encode => false
          )
        end
      end

    end
  end
end
