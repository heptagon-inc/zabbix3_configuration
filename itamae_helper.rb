# http://garin.jp/doc/devops/itamae_secret_data#mok-head3-4
require "reversible_cryptography"
def secret
  secret_file = "properties/secret.yaml.encrepted"
  if @secret.nil?
    password = ENV["ITAMAE_SECRET_PASS"]
    encrypted_data = File.read(secret_file).strip
    decrypted_data = ReversibleCryptography::Message.decrypt(encrypted_data, password)
    @secret = YAML.load(decrypted_data)
  end
  return @secret
end
