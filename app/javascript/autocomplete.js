function initAutocomplete() {
  const inputTitle = document.getElementById("title");
  const inputAddress = document.getElementById("address");

  if (inputTitle && inputAddress) {
    const options = {
      types: ["establishment"],
      componentRestrictions: { country: "JP" },
    };

    const autocompleteTitle = new google.maps.places.Autocomplete(
      inputTitle,
      options
    );
    const autocompleteAddress = new google.maps.places.Autocomplete(
      inputAddress,
      options
    );

    autocompleteTitle.addListener("place_changed", () => {
      const place = autocompleteTitle.getPlace();
      inputTitle.value = place.name;
      inputAddress.value = place.formatted_address;
    });

    autocompleteAddress.addListener("place_changed", () => {
      const place = autocompleteAddress.getPlace();
      inputTitle.value = place.name;
      inputAddress.value = place.formatted_address;
    });
  } else {
    console.error("Input elements not found.");
  }
}

document.addEventListener("DOMContentLoaded", initAutocomplete);
