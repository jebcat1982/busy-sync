class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.save!
    end
  end
end
