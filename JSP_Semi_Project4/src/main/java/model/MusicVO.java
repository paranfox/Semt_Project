package model;

public class MusicVO {
	private String user_id;
	private int music_id;
	private String music_pic;
	private String music_mp3;
	private String music_title;
	private String music_contents;
	private int music_likecnt;
	private int music_playcnt;
	private String user_nickname;
	
	
	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public int getMusic_id() {
		return music_id;
	}

	public void setMusic_id(int music_id) {
		this.music_id = music_id;
	}



	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getMusic_pic() {
		return music_pic;
	}

	public void setMusic_pic(String music_pic) {
		this.music_pic = music_pic;
	}

	public String getMusic_mp3() {
		return music_mp3;
	}

	public void setMusic_mp3(String music_mp3) {
		this.music_mp3 = music_mp3;
	}

	public String getMusic_title() {
		return music_title;
	}

	public void setMusic_title(String music_title) {
		this.music_title = music_title;
	}

	public String getMusic_contents() {
		return music_contents;
	}

	public void setMusic_contents(String music_contents) {
		this.music_contents = music_contents;
	}

	public int getMusic_likecnt() {
		return music_likecnt;
	}

	public void setMusic_likecnt(int music_likecnt) {
		this.music_likecnt = music_likecnt;
	}

	public int getMusic_playcnt() {
		return music_playcnt;
	}

	public void setMusic_playcnt(int music_playcnt) {
		this.music_playcnt = music_playcnt;
	}

}
