document.addEventListener('turbo:load', function () {
  const checkbox = document.querySelector('.public-checkbox');

  if (checkbox) {
    checkbox.addEventListener('change', function () {
      const recipeId = checkbox.dataset.recipeId;
      const newValue = checkbox.checked;

      // Send an AJAX request to update the recipe.public value
      fetch(`/recipes/${recipeId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({ public: newValue }),
      })
        .then(response => response.json())
        .catch(error => console.error('Error:', error));

      // Prevent the default behavior for regular HTML requests

    });
  }
});