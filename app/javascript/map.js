function initMap() {
  const mapElement = document.getElementById("map");

  const ishikawaBounds = {
    north: 37.728803,
    south: 36.010473,
    west: 136.029081,
    east: 137.596202,
  };

  const mapOptions = {
    center: { lat: 36.578057, lng: 136.648957 }, // 石川県の中心座標
    zoom: 9, // ズームレベルを上げて、石川県にズームイン
  };

  const map = new google.maps.Map(mapElement, mapOptions);

  // const bounds = new google.maps.LatLngBounds(
  //   { lat: ishikawaBounds.south, lng: ishikawaBounds.west },
  //   { lat: ishikawaBounds.north, lng: ishikawaBounds.east }
  // );
  // map.fitBounds(bounds);

  const posts = JSON.parse(mapElement.dataset.posts);
  console.log("Loaded posts:", posts); // デバッグ用に追加
  for (const post of posts) {
    const marker = new google.maps.Marker({
      position: { lat: post.latitude, lng: post.longitude },
      map: map,
      title: post.title,
    });

    marker.addListener("click", () => {
      showModal(post);
    });
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
  console.log("Document loaded"); // デバッグ用メッセージ

  if (document.getElementById("map")) {
    console.log("Map element found, initializing map"); // デバッグ用メッセージ
    initMap();
  } else {
    console.log("Map element not found");
  }
});

document.addEventListener("click", (event) => {
  const modal = document.getElementById("my_modal_2");
  if (event.target === modal) {
    modal.close();
  }
});
