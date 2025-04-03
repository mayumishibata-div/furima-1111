window.addEventListener('turbo:load', function () {

  const parentCategory = document.getElementById('parent-category')
  const selectWrap = document.getElementById('select-wrap')

  const selectChildElement = (selectForm) => {

  }

  const XHR = new XMLHttpRequest();
  const categoryXHR = (id) => {
    XHR.open("GET", `/category/${id}`, true);
    XHR.responseType = "json";
    XHR.send();
  }

  const getChildCategoryData = () => {
    const parentValue = parentCategory.value
    categoryXHR(parentValue)

    XHR.onload = () => {
      const items = XHR.response.item;
      appendChildSelect(items)
      const childCategory = document.getElementById('child-select')

      childCategory.addEventListener('change', () => {
        selectChildElement('grand-child-select-wrap')
        getGrandchildCategoryData(childCategory)
      })
    }
  }

  const appendChildSelect = (items) => {

    const childWrap = document.createElement('div')
    const childSelect = document.createElement('select')

    childWrap.setAttribute('id', 'child-select-wrap')
    childSelect.setAttribute('id', 'child-select')
    childSelect.setAttribute('class', 'select-box')

    items.forEach(item => {
      const childOption = document.createElement('option')
      childOption.innerHTML = item.name
      childOption.setAttribute('value', item.id)
      childSelect.appendChild(childOption)
    });

    childWrap.appendChild(childSelect)
    selectWrap.appendChild(childWrap)
  }

  const getGrandchildCategoryData = (grandchildCategory) => {
    const grandchildValue = grandchildCategory.value
    categoryXHR(grandchildValue)

    XHR.onload = () => {
      const GrandChildItems = XHR.response.item;
      appendGrandChildSelect(GrandChildItems)
    }
  }
  
  parentCategory.addEventListener('change', function () {
    selectChildElement('child-select-wrap')
    getChildCategoryData()
  })

})