window.addEventListener('turbo:load', function () {

  const parentCategory = document.getElementById('parent-category')

  const selectChildElement = (selectForm) => {

  }

  const getChildCategoryData = () => {
    const parentValue = parentCategory.value
  }

  parentCategory.addEventListener('change', function () {
    selectChildElement('child-select-wrap')
  })

})