package model;

import java.sql.Timestamp;

public class PlayedMusicVO {
	private int play_id;

	public int getPlay_id() {
		return play_id;
	}

	public void setPlay_id(int play_id) {
		this.play_id = play_id;
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

	public Timestamp getPlay_time() {
		return play_time;
	}

	public void setPlay_time(Timestamp play_time) {
		this.play_time = play_time;
	}

	private String user_id;
	private int music_id;
	private Timestamp play_time;
}
