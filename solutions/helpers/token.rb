require 'base64'
require 'uri'

module Helpers
  module Token
    class AES
      BLOCK_SIZE = 16

      attr_reader :cipher_text

      def initialize(encoded_s)
        @cipher_text = Base64.urlsafe_decode64(
          URI.unescape(encoded_s)
        )
      end

      def to_blocks
        @cipher_text.bytes
          .each_slice(BLOCK_SIZE)
          .map{ |byte| 
            byte.map(&:chr).join 
          }
      end
    end
  end
end