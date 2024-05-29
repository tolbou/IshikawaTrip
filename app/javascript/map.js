function initMap() {
  const mapElement = document.getElementById("map");
  const mapOptions = {
    center: { lat: 36.578057, lng: 136.648957 },
    zoom: 9,
  };
  const map = new google.maps.Map(mapElement, mapOptions);
  updateMarkers(map);
}

function updateMarkers(map) {
  const mapElement = document.getElementById("map");
  const posts = JSON.parse(mapElement.dataset.posts);

  if (window.markers) {
    window.markers.forEach((marker) => marker.setMap(null));
  }
  window.markers = [];

  for (const post of posts) {
    const marker = new google.maps.Marker({
      position: { lat: post.latitude, lng: post.longitude },
      map: map,
      title: post.title,
    });

    marker.addListener("click", () => {
      showModal(post);
    });

    window.markers.push(marker);
  }
}

function showModal(post) {
  const modal = document.getElementById("my_modal_2");
  const modalTitle = document.getElementById("modalTitle");
  const modalTags = document.getElementById("modalTags");
  const modalMonthTags = document.getElementById("modalMonthTags");
  const modalContent = document.getElementById("modalContent");
  const modalImage = document.getElementById("modalImage");
  const modalDetailLink = document.getElementById("modalDetailLink");

  if (
    modal &&
    modalTitle &&
    modalTags &&
    modalMonthTags &&
    modalContent &&
    modalImage &&
    modalDetailLink
  ) {
    modalTitle.textContent = post.title;
    modalTags.textContent = `タグ: ${post.tags
      .map((tag) => tag.title)
      .join(", ")}`;
    modalMonthTags.textContent = `おすすめ時期: ${post.month_tags
      .map((tag) => tag.title)
      .join(", ")}`;
    modalContent.textContent = post.report;
    modalImage.src = post.image_url;
    modalImage.alt = post.title;
    modalDetailLink.href = `/posts/${post.id}`;

    modal.showModal();
  } else {
    console.error("Modal elements not found");
  }
}

document.addEventListener("DOMContentLoaded", () => {
  if (document.getElementById("map")) {
    initMap();
  }

  document
    .getElementById("search-form")
    .addEventListener("submit", function (event) {
      event.preventDefault();
      const formData = new FormData(this);
      const query = new URLSearchParams(formData).toString();

      fetch(`${this.action}?${query}`, {
        headers: { Accept: "application/json" },
      })
        .then((response) => response.json())
        .then((data) => {
          document.getElementById("map").dataset.posts = JSON.stringify(data);
          initMap();
        });
    });

  document
    .getElementById("search-bar-check")
    .addEventListener("change", function (event) {
      const searchFormContainer = document.querySelector(
        ".search-form-container"
      );

      if (this.checked) {
        searchFormContainer.style.height = "auto";
      } else {
        searchFormContainer.style.height = "auto";
      }
    });

  document.getElementById("reset-button").addEventListener("click", () => {
    document.getElementById("search-form").reset();
    fetch(window.location.href, {
      headers: { Accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        document.getElementById("map").dataset.posts = JSON.stringify(data);
        initMap();
      });
  });
});

document.addEventListener("click", (event) => {
  const modal = document.getElementById("my_modal_2");
  if (event.target === modal) {
    modal.close();
  }
});
