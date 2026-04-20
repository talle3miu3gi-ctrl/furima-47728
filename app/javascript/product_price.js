 const priceCalc = () => {
  const priceInput = document.getElementById("item-price");

   if (!priceInput) return;

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    addTaxDom.innerHTML = tax.toLocaleString();
    profitDom.innerHTML = profit.toLocaleString();
  });
};

window.addEventListener('turbo:load', priceCalc);
window.addEventListener("turbo:render", priceCalc);