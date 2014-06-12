require 'spec_helper'
describe User do 
  describe ".top_rated" do 
    before :each do
      @user1 = create(:user)
      @post = create(:post, user: @user1)
      2.times { create(:comment, user: @user1, post: @post)}
      @user1.update_attribute(:role, "member")
      v = Vote.create(value: 1, post: @post)

      @user2 = create(:user)
      @post2 = create(:post, user: @user2)
      4.times { create(:comment, user: @user2, post: @post2)}
      @user2.update_attribute(:role, "moderator")
      v2 = Vote.create(value: -1, post: @post2)

    end
    it "should return users based on comments + posts" do
      User.top_rated.should eq([@user2, @user1])
    end
    it "should have 'posts_count' on user2" do
      users = User.top_rated
      users.first.posts_count.should eq(1)
    end
    it "should have 'comments_count' on user2" do
      users = User.top_rated
      users.first.comments_count.should eq(4)
    end
    it "should have 'posts_count' on user1" do
      users = User.top_rated
      users.second.posts_count.should eq(1)
    end
    it "should have 'comments_count' on user1" do
      users = User.top_rated
      users.second.comments_count.should eq(2)
    end
    it "should return points for user1's post" do
      @post.points.should eq(2)
    end
    it "should return points for user2's post" do
      @post2.points.should eq(0)
    end

    it "should return true for user1's role" do
      @user1.role?("member").should eq(true)
    end
    it "should return true for user2's role" do
      @user2.role?("moderator").should eq(true)
    end
  end
end