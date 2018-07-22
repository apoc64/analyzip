console.log(highIncomes)
console.log(lowIncomes)

var map
var geocoder
var markers = []

function initMap() {
  var options = {
    zoom: 7,
    center: {lat: lat, lng: lng}
  }
  map = new google.maps.Map(document.querySelector('#map'), options);
  var bounds = {
    north: ne_lat,
    south: sw_lat,
    east: ne_lng,
    west: sw_lng
  }
  map.fitBounds(bounds, -10)

  geocoder = new google.maps.Geocoder;

  // map responds to click
  google.maps.event.addListener(map, 'click',
  function(event){
    var latLng = event.latLng
    geocoder.geocode({'location':latLng}, function(results, status) {
      if (status === 'OK') {
        if (results[0]) {
          var marker = addMarker(latLng, results[0].address_components, true)
        } else {
          window.alert('No results found'); // Remove once handled
        }
      } else {
        window.alert('Geocoder failed due to: ' + status); // Remove once handled
      } // end of checkoing status of geocode
    });
  });
} // end of init map

function addMarker(latLng, components, shouldOpen) {
  var marker = new google.maps.Marker({
    position: latLng,
    map: map
  });
  var message = setAddressMessage(components)
  var infoWindow = new google.maps.InfoWindow;
  infoWindow.setContent(message);
  if(shouldOpen){
    infoWindow.open(map, marker);
  };
  // return {
  //   "marker": marker,
  //   "infoWindow": infoWindow
  // }
}

function setAddressMessage(components) {
  var zip = "";
  var county = "";
  var state = "";
  components.forEach(function(component) {
    if(component["types"].includes("postal_code")) {
      zip = component["short_name"];
    };
    if(component["types"].includes("administrative_area_level_2")) {
      county = component["short_name"];
    };
    if(component["types"].includes("administrative_area_level_1")) {
      state = component["long_name"];
    };
  });
  return `<h6><a href="/zips/${zip}">${zip}</a></h6><p>${county}</p><p>${state}</p>`;
} // end of setAddressMessage

if(!(highIncomes === undefined || highIncomes.length == 0)) {
  var highIncomeCard = document.querySelector('.high-incomes');
  highIncomeCard.addEventListener('click', function() {
    highIncomes.forEach(function(zip) {
      geocoder.geocode({address:zip}, function(results, status) {
        if (status === 'OK') {
          if (results[0]) {
            addMarker(results[0]["geometry"]["location"], results[0].address_components, false)
          }
        }
      }) // end geocoder
    }) // end forEach high income
  }) // end high incomes event listener
} // end if high incomes

// class Marker
