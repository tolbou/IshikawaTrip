document.addEventListener("turbo:load", () => {
  const menuIcon = document.getElementById("menuIcon");
  const menu = document.getElementById("menu");
  if (menuIcon && menu) {
    menuIcon.addEventListener("click", () => {
      menu.classList.toggle("hidden");
      menuIcon.classList.toggle("fa-bars");
      menuIcon.classList.toggle("fa-times");
    });
  }
});
