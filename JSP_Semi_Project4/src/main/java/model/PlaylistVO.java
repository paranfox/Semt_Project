package model;

public class PlaylistVO {
	
	private int playlist_id;
    private String user_Id;
    private String playlist_name;
	
    public int getPlaylist_id() {
		return playlist_id;
	}

	public void setPlaylist_id(int playlist_id) {
		this.playlist_id = playlist_id;
	}

	public String getUser_Id() {
		return user_Id;
	}

	public void setUser_Id(String user_Id) {
		this.user_Id = user_Id;
	}

	public String getPlaylist_name() {
		return playlist_name;
	}

	public void setPlaylist_name(String playlist_name) {
		this.playlist_name = playlist_name;
	}

    // (int, String) 형태의 생성자 추가
    public PlaylistVO(String userId, String name) {
        this.user_Id = userId;
        this.playlist_name = name;
    }

}