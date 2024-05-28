// Place Autocomplete
document.addEventListener("DOMContentLoaded", () => {
  const inputTitle = document.getElementById("title");
  const inputAddress = document.getElementById("address");

  //オートコンプリートのオプション
  const options = {
    types: ["establishment"], // 店名や施設名に絞り込み
    componentRestrictions: { country: "JP" },
  };

  // オートコンプリート適用
  const autocompleteTitle = new google.maps.places.Autocomplete(
    inputTitle,
    options
  );
  const autocompleteAddress = new google.maps.places.Autocomplete(
    inputAddress,
    options
  );

  // タイトルのオートコンプリートが選択されたとき
  autocompleteTitle.addListener("place_changed", () => {
    const place = autocompleteTitle.getPlace();
    inputTitle.value = place.name;
    inputAddress.value = place.formatted_address;
  });

  // 住所のオートコンプリートが選択されたとき
  autocompleteAddress.addListener("place_changed", () => {
    const place = autocompleteAddress.getPlace();
    inputTitle.value = place.name;
    inputAddress.value = place.formatted_address;
  });
});
