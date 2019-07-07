<<<<<<< HEAD
class Post < ApplicationRecord
  validates :content,{presence:true,length:{maximum:300}}
  validates :user_id,{presence:true}
  # mount_uploader :image, ImageUploader
  def user
    return User.find_by(id: self.user_id)
  end
=======
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
>>>>>>> エラーメッセージの日本語設定など
end
