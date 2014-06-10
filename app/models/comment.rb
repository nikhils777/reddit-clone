class Comment < ActiveRecord::Base

belongs_to :post
belongs_to :user
after_create :send_favorite_emails
default_scope { order('created_at DESC') }

private

def send_favorite_emails
  self.post.favorites.each do |favorite|
    FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
  end
end

end
