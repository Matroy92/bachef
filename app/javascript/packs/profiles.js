const stopAutoplayonHover = () => {
    if (document.getElementsByClassName('cercle')) {
        const gif = document.querySelectorAll(".cercle-gif")
        gif.forEach((item) => item.addEventListener("mouseenter", (event) => {
            event.target.play();
        }));
        gif.forEach((item) => item.addEventListener("mouseleave", (event) => {
            event.target.pause();
        }));
    }
}

export { stopAutoplayonHover };