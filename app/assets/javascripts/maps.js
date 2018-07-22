console.log(highIncomes)
console.log(lowIncomes)

var map
var geocoder
var markers = []
var addressMarkers = []

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
  addMapListener();
} // end of init map

function addMapListener() {
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
      } // end of checking status of geocode
    });
  });
}

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
  }; // else?
  // addEnventListener??
  markers.push([marker, infoWindow])
  return marker
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

// if map has high income card, set event listener:
if(!(highIncomes === undefined || highIncomes.length == 0)) {
  var highIncomeCard = document.querySelector('.high-incomes');
  highIncomeCard.addEventListener('click', function() {
    setMarkers(highIncomes)
  }) // end high incomes event listener
} // end if high incomes

// if map has low income card, set event listener:
if(!(lowIncomes === undefined || lowIncomes.length == 0)) {
  var lowIncomeCard = document.querySelector('.low-incomes');
  lowIncomeCard.addEventListener('click', function() {
    setMarkers(lowIncomes)
  }) // end high incomes event listener
} // end if high incomes

function setMarkers(addresses) {
  clearAllMarkers()
  addresses.forEach(function(address) {
    // not always doing all 10 ???
    if(addressMarkers[address]) {
      addressMarkers[address].setMap(map)
    } else {
      geocoder.geocode({address:address}, function(results, status) {
        if (status === 'OK' && results[0]) {
          var marker = addMarker(results[0]["geometry"]["location"], results[0].address_components, false)
          addressMarkers[address] = marker
        } else {
          // Why? Performance? Try again?
          console.log(`Failed to add marker: ${address}`)
        }
      }) // end geocoder
    } // end if else marker already exists
  }) // end forEach high income
} // end setMarkers

function clearAllMarkers() {
  markers.forEach(function(marker) {
    marker[0].setMap(null);
  })
}
// class Marker
