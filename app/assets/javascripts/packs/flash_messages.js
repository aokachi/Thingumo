document.addEventListener("turbolinks:load", () => {
  const flashMessages = document.querySelectorAll(".flash");

  flashMessages.forEach((flash) => {
    setTimeout(() => {
      flash.style.display = "none";
    }, 3000);
  });
});