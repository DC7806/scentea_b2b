window.addEventListener('DOMContentLoaded', () => {
  $('#product-image-sliders').slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    autoplay: true,
    arrows: false,
    asNavFor: '#slider-nav'
  })

  $('#slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '#product-image-sliders',
    arrows: true,
    centerMode: true,
    focusOnSelect: true
  })
})

