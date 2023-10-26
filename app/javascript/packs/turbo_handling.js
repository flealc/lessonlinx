document.addEventListener('turbo:frame-load', (event) => {
  if (event.target.id === 'student-details') {
    const newUrl = event.target.src || event.target.dataset.src;
    if (newUrl) {
      history.pushState({ turbo: true }, '', newUrl);
    }
  }
});
