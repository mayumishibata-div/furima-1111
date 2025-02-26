window.addEventListener('turbo:load', () => {

  // 金額を入力する場所のidセレクタ
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");

  priceInput.addEventListener("input", () => {
    const inputValue = parseFloat(priceInput.value); // 入力値を数値に変換

    if (!isNaN(inputValue)) { // 入力が数値であることを確認
      const tax = Math.floor(inputValue * 0.1); // 販売手数料（10%）を計算

        addTaxDom.innerHTML = `${tax}`; // 結果を表示
        // console.log(addTaxDom.innerHTML); // コンソールにも表示（デバッグ用）
    
    } else {
        addTaxDom.innerHTML = ""; // 入力が無効な場合は空にする
    }
  });
});