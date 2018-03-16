// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
////////////////////////////////////////
//
// For turbolinks to work, these jQuery libraries must be loaded first and
// turbolinks last. Put other libraries in the marked area in the middle.
//
//= require jquery
// require jquery.turbolinks
//= require jquery_ujs

////////////////////////////////////////
///////  Load dependencies here  ///////

// Bootstrap Javascript
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/scrollspy
//= require twitter/bootstrap/tab
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/button
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/carousel
//= require twitter/bootstrap/affix

//= require_tree .

////////////////////////////////////////

// require turbolinks
// require google-analytics-turbolinks
var mymap;

(function() {
  $(document).ready(function() {
    $map = $('div#country_map');
    mymap = L.map('country_map').setView([$map.data('lat'), $map.data('lon')], $map.data('map-zoom-level'));

    L.tileLayer(gon.mapbox_url, {
        maxZoom: 18,
        id: 'country_map',
        accessToken: gon.mapbox_token
    }).addTo(mymap);
  });
})();


