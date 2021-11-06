const getSelectedCheckboxValues = () => {
    function onlyUnique(value, index, self) {
        return self.indexOf(value) === index;
    }

    if (document.getElementById('game_checkbox')) {
        const card_checklist = document.querySelector(".card_checklist");
        const ids = []
        card_checklist.addEventListener("drop", (event) => {
            setTimeout(() => {
                const cards = document.querySelectorAll('.card_checklist .draggable')
                cards.forEach(element => ids.push(element.dataset.id))
                const input = document.querySelector(".game_cards input");
                const uniqArr = ids.filter(onlyUnique)
                input.value = uniqArr
                console.log(uniqArr)
            }, 10)
        });
    }
}

export { getSelectedCheckboxValues };