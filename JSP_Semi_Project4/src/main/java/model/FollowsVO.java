package model;

public class FollowsVO {
	private int follow_id;
	private String follower_id;
	private String followed_id;
	private String created_at;

	public int getFollow_id() {
		return follow_id;
	}

	public void setFollow_id(int follow_id) {
		this.follow_id = follow_id;
	}

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

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

}
