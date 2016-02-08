require "addressable/uri"
require "openssl"

class SecureLink
  def self.generate(url: , data: )
    uri = Addressable::URI.parse url
    token, iv = encrypt(data)
    uri.query_values = (uri.query_values || {}).merge({
      entry_data:  Base64.urlsafe_encode64(token),
      iv: iv
    })
    uri.to_s
  end

  def self.decrypt(entry_data:, iv:)
    JSON.parse(openssl_decrypt(Base64.urlsafe_decode64(entry_data), iv))
  rescue
    {}
  end

  private
  def self.encrypt(payload)
    cipher = OpenSSL::Cipher::AES256.new(:CFB)
    cipher.encrypt
    cipher.key = ENV["LINK_SECRET"]
    iv = cipher.iv = SecureRandom.hex(16)
    [cipher.update(payload) + cipher.final, iv]
  end

  def self.openssl_decrypt encrypted_data, iv
    decipher = OpenSSL::Cipher::AES256.new(:CFB)
    decipher.decrypt
    decipher.key = ENV['LINK_SECRET']
    decipher.iv = iv
    decipher.update(encrypted_data) + decipher.final
  end
end
