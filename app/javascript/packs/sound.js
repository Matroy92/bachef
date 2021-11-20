


function playsound() {
    const showElement = document.getElementById('container-show')
    const media = document.getElementById('sound')
    if (showElement) {
        media.play();
        media.volume = 1;
    } else {
        if (media) {
            media.stop()
        }
    }

};

export { playsound };