package model;

public class FollowersProfileVO {
	private String follower_id;
	private String followed_id;
	private int followers_count;
	private String user_nickname;
	private String user_pic;

	public String getFollower_id() {
		return follower_id;
	}

	public void setFollower_id(String follower_id) {
		this.follower_id = follower_id;
	}

	public String getFollowed_id() {
		return followed_id;
	}

	public void setFollowed_id(String followed_id) {
		this.followed_id = followed_id;
	}

	public int getFollowers_count() {
		return followers_count;
	}

	public void setFollowers_count(int followers_count) {
		this.followers_count = followers_count;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_pic() {
		return user_pic;
	}

	public void setUser_pic(String user_pic) {
		this.user_pic = user_pic;
	}

}
