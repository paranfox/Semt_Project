const audioPlayer = document.querySelector("#audioPlayer");

function handleClickPlayButton(event) {
     const mp3Path = event.target.dataset.mp3;
     const albumTitle = event.target.dataset.albumTitle;
     const albumImage = event.target.dataset.image;
     const audioPlayer = document.getElementById("audioPlayer");
     
     audioPlayer.querySelector("source").src = mp3Path;
     audioPlayer.load();
     audioPlayer.play();

     document.getElementById("albumTitle").textContent = albumTitle;
     document.getElementById("albumImage").src = albumImage;
   }
   
document.addEventListener("DOMContentLoaded", function () {
     const playButtons = document.getElementsByClassName("playMusicBtn");
     for (let i = 0; i < playButtons.length; i++) {
       playButtons[i].addEventListener("click", handleClickPlayButton);
     }
   });