const initCardSelection = () => {
    const clickableCards = document.querySelectorAll('.clickable');
    const toggleActiveClass = (event) => {
        event.currentTarget.classList.toggle("active");
      };
    const bindCardToClick = (card) => {
        card.addEventListener('click', toggleActiveClass);
      };

      clickableCards.forEach(bindCardToClick);
}

export { initCardSelection };
