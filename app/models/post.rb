class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :content,{presence:true,length:{maximum:300}}
  validates :user_id,{presence:true}
  # mount_uploader :image, ImageUploader
  def user
    return User.find_by(id: self.user_id)
  end
end
