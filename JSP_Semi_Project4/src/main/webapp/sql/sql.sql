DROP TABLE USER;
DROP TABLE COMMENTS;
DROP TABLE MUSIC_INFO;
DROP TABLE FEED;
DROP TABLE FOLLOWS;
COMMIT;

SET FOREIGN_KEY_CHECKS = 0;

-- USER 테이블
CREATE TABLE USER(
user_id varchar(20) primary key,
user_pwd varchar(20) not null,
user_name varchar(20) not null,
user_nickname varchar(20) not null,
user_email varchar(20) not null,
user_phone varchar(20) not null,
user_pic mediumblob 
);

-- MUSIC_INFO 테이블
create table MUSIC_INFO(
music_id int auto_increment primary key,
music_pic varchar(1000),
music_mp3 varchar(10000) not null,
music_title varchar(20) not null unique,
music_contents varchar(500),
music_likecnt int default 0,
music_playcnt int default 0,
user_nickname varchar(40) not null,
user_id varchar(40), FOREIGN KEY (user_id)
REFERENCES USER(user_id) ON UPDATE CASCADE
);

-- COMMENTS
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    album_id INT,
    user_id varchar(20),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES music_info(music_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE follows (
	follow_id INT AUTO_INCREMENT PRIMARY KEY,	-- 팔로우 관계 id
    follower_id VARCHAR(40),					-- 팔로우 하는 유저
	followed_id VARCHAR(40),					-- 팔로우 받는 유저
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(follower_id) REFERENCES user(user_id),	
    FOREIGN KEY(followed_id) REFERENCES user(user_id)    
);

COMMIT;

