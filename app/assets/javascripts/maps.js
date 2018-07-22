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
  var infoWindow = new google.maps.InfoWindow;

  // map responds to click
  google.maps.event.addListener(map, 'click',
  function(event){
    var latLng = event.latLng
    console.log(JSON.stringify(latLng));
    geocoder.geocode({'location':latLng}, function(results, status) {
      if (status === 'OK') {
        if (results[0]) {
          var marker = new google.maps.Marker({
            position: latLng,
            map: map
          });
          var message = setAddressMessage(results[0].address_components)
          infoWindow.setContent(message);
          infoWindow.open(map, marker);
        } else {
          window.alert('No results found'); // Remove once handled
        }
      } else {
        window.alert('Geocoder failed due to: ' + status); // Remove once handled
      } // end of checkoing status of geocode
    });
  });
} // end of init map

function setAddressMessage(components) {
  console.log(components.length);
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
  console.log("highIncomes")
  var highIncomeCard = document.querySelector('.high-incomes');
  highIncomeCard.addEventListener('click', function() {
    highIncomes.forEach(function(zip) {
      console.log(zip)
      geocoder.geocode({address:zip}, function(results, status) {
        if (status === 'OK') {
          if (results[0]) {
            console.log(results[0]["geometry"])
            var marker = new google.maps.Marker({
              position: results[0]["geometry"]["location"],
              map: map
            });
            // var message = setAddressMessage(results[0].address_components)
          }
        }
      })
    })
  })
}

// class Marker
