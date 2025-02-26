window.addEventListener('turbo:load', () => {

  // 金額を入力する場所のidセレクタ
  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      console.log(inputValue);
    })
});