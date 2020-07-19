// Left bar accordion
$(function () {
  $('#nav-accordion').dcAccordion({
    eventType: 'click',
    autoClose: true,
    saveState: true,
    disableLink: true,
    speed: 'slow',
    showCount: false,
    autoExpand: true,
    classExpand: 'dcjq-current-parent'
  })
})


$(function () {

  // sidebar dropdown menu auto scrolling
  jQuery('#sidebar .sub-menu > a').on('click', function () {
    var o = ($(this).offset())
    var diff = 250 - o.top

    if (diff > 0)
      $('#sidebar').scrollTo('-=' + Math.abs(diff), 500)
    else
      $('#sidebar').scrollTo('+=' + Math.abs(diff), 500)
  })

  // sidebar toggle
  $('.sidebar-toggle-box').on('click', function () {
    $(document.body).toggleClass('is-sidebar-nav-open')
  })

  // Sidebar scroll
  $('#sidebar').niceScroll({
    styler:'fb',
    cursorcolor:'#e8403f',
    cursorwidth: '3',
    cursorborderradius: '10px',
    background: '#404040',
    spacebarenabled:false,
    cursorborder: '',
    scrollspeed: 60
  })

  // Widget tools
  jQuery('.card .tools .fa-chevron-down').on('click', function () {
    var el = jQuery(this).parents('.card').children('.card-body')
    if (jQuery(this).hasClass('fa-chevron-down')) {
      jQuery(this).removeClass('fa-chevron-down').addClass('fa-chevron-up')
      el.slideUp(200)
    } else {
      jQuery(this).removeClass('fa-chevron-up').addClass('fa-chevron-down')
      el.slideDown(200)
    }
  })

  jQuery('.card .tools .fa-times').on('click', function () {
    jQuery(this).parents('.card').parent().remove()
  })

  // Custom bar chart
  if ($('.custom-bar-chart')) {
    $('.bar').each(function () {
      var i = $(this).find('.value').html()
      $(this).find('.value').html('')
      $(this).find('.value').animate({
        height: i
      }, 2000)
    })
  }

})
