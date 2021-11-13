
const quantityProducts = () => {
    const quantityArrowMinus = document.querySelector(".quantity-arrow-minus");
    if (quantityArrowMinus) {
        const quantityArrowPlus = document.querySelector(".quantity-arrow-plus");
        const quantityNum = document.querySelector(".quantity-num");
        quantityArrowMinus.addEventListener("click", () => {
            if (parseInt(quantityNum.value, 10) > 1) {
                quantityNum.value = parseInt(quantityNum.value, 10) - 1;
            }
        });
        quantityArrowPlus.addEventListener("click", () => {
            quantityNum.value = parseInt(quantityNum.value, 10) + 1;
        });
    }
};

export { quantityProducts }