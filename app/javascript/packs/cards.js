const getSelectedCheckboxValues = () => {
    if (document.getElementById('game_checkbox')) {
        const cards = document.querySelectorAll(".card-1");
        cards.forEach((card) => {
            card.addEventListener("click", (event) => {
                const card_id = event.currentTarget.dataset.id;
                const checkbox = document.querySelector(`.form-check-input.check_boxes.optional[value='${card_id}']`);
                checkbox.click();
                if (checkbox.checked) {
                    card.querySelectorAll('.card-1__side').forEach((elem) => {
                        elem.classList.add('card-selected')
                    })
                } else {
                    card.querySelectorAll('.card-1__side').forEach((elem) => {
                        elem.classList.remove('card-selected')
                    })
                }
            });
        });
    }
}

export { getSelectedCheckboxValues };