
const initBtnSubmit = () => {
    if (document.getElementById('game_new')) {
        const btn = document.querySelector('.btn-bachef')
        const form = document.querySelector('#new_game')
        btn.addEventListener('click', () => {
            form.submit()
        })
    }

}
export { initBtnSubmit };