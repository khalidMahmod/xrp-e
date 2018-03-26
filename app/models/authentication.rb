class Authentication < ActiveRecord::Base
  belongs_to :member, required: true

  validates :provider, presence: true, uniqueness: { scope: :member_id }
  validates :uid,      presence: true, uniqueness: { scope: :provider }

  # attr_encrypted :userid, key: 'password'

  class << self
    def locate(auth)
       # salt = SecureRandom.random_bytes(64)
       # key = ActiveSupport::KeyGenerator.new('password').generate_key(salt)
       #  crypt = ActiveSupport::MessageEncryptor.new(key)
       #  consumer_key = Authentication.find_by_uid(1).uid
       # x = crypt.decrypt_and_verify(consumer_key)
       # debugger
       # k=0
      uid      = auth['uid'].to_s
      provider = auth['provider']
      find_by_provider_and_uid(provider, uid)


    end

    def build_auth(auth)
      # salt = SecureRandom.random_bytes(64)
      # key =  ActiveSupport::KeyGenerator.new('password').generate_key(salt)
      # crypt = ActiveSupport::MessageEncryptor.new(key)
      new \
        uid:   auth['uid'],
        provider: auth['provider'],
        secret:   auth&.dig('credentials', 'secret'),
        nickname: auth&.dig('info', 'nickname')
    end
  end
end
