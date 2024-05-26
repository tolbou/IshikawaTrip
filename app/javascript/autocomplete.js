document.addEventListener("DOMContentLoaded", () => {
  const autocompleteInput = document.getElementById("autocomplete");
  const titleInput = document.getElementById("title");

  if (autocompleteInput) {
    const autocomplete = new google.maps.places.Autocomplete(
      autocompleteInput,
      {
        types: ["geocode"],
        componentRestrictions: { country: "jp" }, // 日本の住所のみを対象
      }
    );

    autocomplete.addListener("place_changed", () => {
      const place = autocomplete.getPlace();
      if (place.address_components) {
        let address = "";
        for (const component of place.address_components) {
          if (
            component.types.includes("route") ||
            component.types.includes("sublocality") ||
            component.types.includes("locality")
          ) {
            address += component.long_name + " ";
          }
        }
        autocompleteInput.value = address.trim();
        titleInput.value = place.name;
      }
    });
  }
});

function initAutocomplete() {
  const autocomplete = new google.maps.places.Autocomplete(
    document.getElementById("autocomplete"),
    { types: ["geocode"] }
  );

  autocomplete.addListener("place_changed", () => {
    const place = autocomplete.getPlace();
    document.getElementById("title").value = place.name;
    document.getElementById("autocomplete").value = place.formatted_address;
  });
}
