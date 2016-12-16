class User < ApplicationRecord
  GMAIL_ENDING = %r{@gmail.com\z}

  def self.from_omniauth(auth, current_user:)
    if current_user && current_user.business_email.blank?
      current_user.business_name = auth.info.name
      current_user.business_image = auth.info.image
      current_user.business_email = auth.extra.id_info.email
      current_user.save!
      current_user
    elsif current_user && current_user.personal_email.blank?
      current_user.personal_name = auth.info.name
      current_user.personal_image = auth.info.image
      current_user.personal_email = auth.extra.id_info.email
      current_user.save!
      current_user
    else
      where(uid: auth.uid).first_or_initialize.tap do |user|
        user.uid = auth.uid
        if GMAIL_ENDING =~ auth.extra.id_info.email
          user.personal_name = auth.info.name
          user.personal_image = auth.info.image
          user.personal_email = auth.extra.id_info.email
        else
          user.business_name = auth.info.name
          user.business_image = auth.info.image
          user.business_email = auth.extra.id_info.email
        end
        user.save!
      end
    end
  end
end
