
const initBtnSubmit = () => {
    if (document.getElementById('game_new')) {
        const btn = document.querySelector('.btn-bachef')
        const form = document.querySelector('#new_game')
        btn.addEventListener('click', () => {
            form.submit()
        })
    }
}

const initBtnFinishSubmit = () => {
    if (document.getElementById('game_save')) {
        const btn = document.querySelector('#submit-finish')
        const form = document.querySelector('#save_game')
        btn.addEventListener('click', () => {
            form.submit()
        })
    }
}

export { initBtnSubmit };
export { initBtnFinishSubmit };