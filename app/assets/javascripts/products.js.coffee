$(document).ready ->
  if $('#infinite-scrolling').size() > 0
    return $(window).on('scroll', ->
      products_url = $('.pagination .next_page a').attr('href')
      if products_url and $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('#loader').fadeIn 'slow', ->
          $.getScript products_url
          return
      return
    )