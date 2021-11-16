


function playsound() {
    const showElement = document.getElementById('container-show')
    const media = document.getElementById('sound')
    if (showElement){
        media.play();
        media.volume = 0.2;
    }else{
        media.stop()
    } 

};

export { playsound };