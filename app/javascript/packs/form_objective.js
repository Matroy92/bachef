const getSelectedObjective = () => {
    if (document.getElementById('new_game_objective')) {
        console.log("Hello");
        const rounds = document.querySelectorAll(".cercle");
        console.log("Hello rounds");
        console.log(rounds);
        rounds.forEach((round) => {
            round.addEventListener("click", (event) => {
                const objective = event.currentTarget.dataset.obj;
                console.log(objective);
                const input = document.getElementById('game_objective');
                input.value = objective;
                
                // const radio = document.querySelector(`.form-check-input.radio_buttons.optional[value='${objective_id}']`);
                // console.log(radio);
                // radio.click();
                // if (radio.checked) {
                //     round.querySelectorAll('.cercle').forEach((elem) => {
                //         elem.classList.add('cercle-selected')
                //     })
                // } else {
                //     round.querySelectorAll('.cercle').forEach((elem) => {
                //         elem.classList.remove('cercle-selected')
                //     })
                // }
            });
        });
    }
}

export { getSelectedObjective }