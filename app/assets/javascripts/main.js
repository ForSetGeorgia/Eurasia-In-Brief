//= require jquery
// Bootstrap Javascript
//= require twitter/bootstrap/transition
//*= require twitter/bootstrap/alert
//*= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//*= require twitter/bootstrap/scrollspy
//*= require twitter/bootstrap/tab
//*= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/button
//= require twitter/bootstrap/collapse
//*= require twitter/bootstrap/carousel
//*= require twitter/bootstrap/affix


//= require utils
//= require enet_nav

(function() {
  // index grid item to be same height
  countryElements = document.querySelectorAll('.country-story')
  if(countryElements.length) {
    function countryHeightRefresh() {
      var maxHeight = 0
      countryElements.forEach(function (countryElement) {
        countryElement.style.height = 'auto'
        if(countryElement.offsetHeight > maxHeight) {
          maxHeight = countryElement.offsetHeight
        }
      })
      countryElements.forEach(function (countryElement) {
        countryElement.style.height = maxHeight + 'px'
      })
    }
    countryHeightRefresh()
    window.onresize = countryHeightRefresh
  }



 // map logic
  var mapContainer = document.querySelector('div#country_map')
  if(mapContainer) {
    var map = L.map('country_map', {
      zoomControl: false,
      attributionControl: false,
    }).setView(
      [
        mapContainer.getAttribute('data-lat'),
        mapContainer.getAttribute('data-lon')
      ],
      mapContainer.getAttribute('data-map-zoom-level')
    )
    L.tileLayer(gon.mapbox_url + '?access_token=' + gon.mapbox_token, {}).addTo(map);
  }

  // countries list popup logic
  var countriesListToggle = document.querySelector('.countries-popup-toggle')
  var countriesListPopup = document.querySelector('.countries-popup')
  if(countriesListToggle && countriesListPopup) {
    var countriesListPopupClose = countriesListPopup.querySelector('.content .close')
    var showCountriesList = function (event) {
      addClass(countriesListPopup, 'open')
    }
    countriesListToggle.addEventListener('click', showCountriesList, false)
    countriesListPopupClose.addEventListener('click', function () {
      removeClass(countriesListPopup, 'open')
    }, false)

    window.onkeydown = function( event ) {
        if ( event.keyCode == 27 ) {
          removeClass(countriesListPopup, 'open')
        }
    };
  }

  // position header for desktop
  var countryHeader = document.querySelector('.country article header')
  if(countryHeader) {
    var countryHeaderSpan = countryHeader.querySelector('h1 span')
    if(countryHeaderSpan) {
      var countryHeaderleft = +getStyle(countryHeader, 'left').replace('px', '')
      var countrySpanWidth = countryHeaderSpan.offsetWidth
      countryHeader.style.left = (countryHeaderleft - countrySpanWidth) + 'px'
    }
  }
})()
