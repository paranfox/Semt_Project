/*music list.jsp*/

document.write("script");

const audioPlayer = document.querySelector("#audioPlayer");

document.querySelectorAll(".album-image").forEach((img) => {
	img.addEventListener("click", (event) => {
		const mp3Path = event.target.dataset.mp3;
		const albumTitle = event.target.dataset.albumTitle;
		const albumImage = event.target.dataset.image;
		audioPlayer.querySelector("source").src = mp3Path;
		audioPlayer.load();
		audioPlayer.play();

		document.getElementById("albumTitle").textContent = albumTitle;
		document.getElementById("albumImage").src = albumImage;
	});
});


document.querySelectorAll(".goToContentBtn").forEach((btn) => {
	btn.addEventListener("click", function(event) {
		event.preventDefault();


		const selectedAlbumId = event.target.dataset.albumId;


		$.ajax({
			url: "<%=request.getContextPath()%>/user_music_content.do",
			type: "GET",
			data: { id: selectedAlbumId },
			success: function(data) {

				document.querySelector(".container").innerHTML = data;
			},
			error: function(error) {
				console.error("Error fetching music content:", error);
			},
		});
	});
});
