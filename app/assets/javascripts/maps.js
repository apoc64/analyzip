var map
var geocoder
const mapInfo = document.querySelector('#map-info')
var markers = []
var addressMarkers = []
var linkClicked = false
var openInfoWindow = null

const bounds = {
  north: ne_lat,
  south: sw_lat,
  east: ne_lng,
  west: sw_lng
}

if(!geoUnit) {
  var geoUnit = "zip codes"
}

function initMap() {
  var options = {
    zoom: 7,
    center: {lat: lat, lng: lng}
  }
  map = new google.maps.Map(document.querySelector('#map'), options);
  map.fitBounds(bounds, -10)
  geocoder = new google.maps.Geocoder;
  addMapListener();
} // end of init map

function addMapListener() {
  google.maps.event.addListener(map, 'click',
  function(event){
    var latLng = event.latLng
    geocoder.geocode({'location':latLng}, function(results, status) {
      if (status === 'OK' && results[0]) {
        var marker = addMarker(latLng, results[0].address_components, true)
      } else {
        console.log('Geocoder failed, status: ' + status + ', results: ' +results);
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
    openWindow(infoWindow, marker)
  }
  marker.addListener('click', function() {
    openWindow(infoWindow, marker)
  })
  markers.push([marker, infoWindow])
  return marker
}

function openWindow(infoWindow, marker) {
  if(openInfoWindow) {
    openInfoWindow.close()
  }
  infoWindow.open(map, marker)
  openInfoWindow = infoWindow
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

// intercept card listeners on link click
const links = document.querySelectorAll('a')
links.forEach(function(link) {
  link.addEventListener('click', function() {
    linkClicked = true
  })
})

// Event listeners for cards:
if(!(highIncomes === undefined || highIncomes.length == 0)) {
  const highIncomeCard = document.querySelector('.high-incomes');
  highIncomeCard.addEventListener('click', function() {
    placeMarkers(highIncomes, "Highest income")
  }) // end high incomes event listener
} // end if high incomes

if(!(lowIncomes === undefined || lowIncomes.length == 0)) {
  const lowIncomeCard = document.querySelector('.low-incomes');
  lowIncomeCard.addEventListener('click', function() {
    placeMarkers(lowIncomes, "Lowest income")
  }) // end high incomes event listener
} // end if high incomes

if(!(prematureDeath === undefined || prematureDeath.length == 0)) {
  const prematureDeathCard = document.querySelector('.premature-death');
  prematureDeathCard.addEventListener('click', function() {
    placeMarkers(prematureDeath, "Highest rates of premature death")
  })
}

if(!(lowBirthWeight === undefined || lowBirthWeight.length == 0)) {
  const lowBirthWeightCard = document.querySelector('.low-birth-weight');
  lowBirthWeightCard.addEventListener('click', function() {
    placeMarkers(lowBirthWeight, "Highest percentage of low birth weight")
  })
}

if(!(diabetesPrevalence === undefined || diabetesPrevalence.length == 0)) {
  const diabetesPrevalenceCard = document.querySelector('.diabetes');
  diabetesPrevalenceCard.addEventListener('click', function() {
    placeMarkers(diabetesPrevalence, "Highest rates of diabetes")
  })
}

if(!(highPopulations === undefined || highPopulations.length == 0)) {
  const highPopulationsCard = document.querySelector('.highest-pops');
  highPopulationsCard.addEventListener('click', function() {
    placeMarkers(highPopulations, `Highest population ${geoUnit}`)
  })
}

function placeMarkers(cardData, message) {
  if(!linkClicked) {
    setMarkers(cardData)
    mapInfo.innerHTML = `<h6 class="center">${message} ${geoUnit} in ${title}:</h6>`
    map.fitBounds(bounds, -10)
  }
}

const baseCard = document.querySelector('.base-card');
baseCard.addEventListener('click', function() {
  clearAllMarkers()
  mapInfo.innerHTML = ""
  map.fitBounds(bounds, -10)
})

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
          // Why? Performance? Over Query limit - 5,000 requests in 100 seconds???
          console.log(`Failed to add marker: ${address}, status: ${status}, results: ${results}`)
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
