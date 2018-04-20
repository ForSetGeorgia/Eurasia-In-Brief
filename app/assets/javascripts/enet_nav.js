$(document).on('ready', function() {


  // menu
  $('.navbar-toggle').on('click', function(e) {
    if ($('.topics-menu').is(':visible')) {
      $('.topics-menu').hide();
    }
    if ($('.regions-menu').is(':visible')) {
      $('.regions-menu').hide();
    }
  })

  $('.close-menu').on('click', function(e) {
    e.preventDefault();
    $('.regions-menu, .topics-menu').hide();
  })

  // search
  $('#search-submit').on('click', function(e) {
    e.preventDefault();
    var query = $('#search-input').val();
    window.location = 'https://eurasianet.org/search/' + encodeURIComponent(query);
  })


  $('#search-input').on('keyup', function(e) {
    console.log('search')
    var query = $('#search-input').val()
    var list = {}
    $('.search-suggestion').remove()
    $.getJSON('/json/suggester/author/' + query, function(data) {
      $('.search-suggestion').remove()
      //console.log(data)
      if (data.length > 0) {
        $('.search-suggester').show()
        _.each(data, function(item) {
          $('.search-suggester').append('<a class="search-suggestion" href="/search/' + item.suggestion + '">' + item.suggestion + '</a>')
        })
      } else {
        $('.search-suggester').hide()
      }
    })
    if (query === '') {
     $('.search-suggester').hide()
    }
  })


  // regions
  $('.regions-menu-toggle').on('click', function(e) {
    e.preventDefault();
    $('.topics-menu').hide();
    $('.regions-menu').toggle();
  })

  // topics
  $('.topics-menu-toggle').on('click', function(e) {
    e.preventDefault();
    $('.regions-menu').hide();
    $('.topics-menu').toggle();
  })

  // more
  $('.more-menu-toggle').on('click', function(e) {
    e.preventDefault();
    $('.topics-menu').hide();
    $('.regions-menu').hide();
  })

  var n = 1;
  $('.btn-load-more').on('click', function(e) {
    console.log('loading...');
    var term = $(this).data('term')
    $.getJSON('https://api.eurasianet.org/rest/term?tid=' + term + '&page=' + n, function(data) {
       console.log(data)
        n++;
        if (data.length < 10) {
          $('.btn-more').hide();
        }
        _.each(data, function(row, index) {
          var image = '';
          var imageClass = '';
          if (row.field_image) {
            image = '<div class="image" style="background-image:url(https://api.eurasianet.org/' + row.field_image + ');"></div>'
          } else {
            imageClass = 'no-image';
          }
         $('.main').append(
           '<div class="article-wrapper ' + imageClass + '">'
            + '<div class="text">'
            + '<h2><a href="/s/' + row.field_slug + '">' + row.title + '</a></h2>'
            + '<a href="/s/' + row.field_slug + '">'
            + image
            + '</a>'
            + '<div class="article-info"><span><a href="#">' + row.author + '</a></span> '
            + row.date + '</div>'
            + '</div>'
           + '</div>'
         )
       });
    });
  });
});
