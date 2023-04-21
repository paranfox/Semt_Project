package model;

public class MusicLikesVO {

	private int id;
	private String user_id;
	private int music_id;
	private boolean is_liked;
	private boolean is_disliked;

	public boolean getIs_liked() {
		return is_liked;
	}

	public void setIs_liked(boolean is_liked) {
		this.is_liked = is_liked;
	}

	public boolean getIs_disliked() {
		return is_disliked;
	}

	public void setIs_disliked(boolean is_disliked) {
		this.is_disliked = is_disliked;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getMusic_id() {
		return music_id;
	}

	public void setMusic_id(int music_id) {
		this.music_id = music_id;
	}

	public boolean isIs_liked() {
		return is_liked;
	}

	public boolean isIs_disliked() {
		return is_disliked;
	}

}
