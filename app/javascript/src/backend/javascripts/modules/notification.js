window.addEventListener('DOMContentLoaded', () => {
  var notification = document.getElementById('notification')

  if (!notification) { return }

  notification.style.transition= 'opacity 2.5s ease-in-out'
  notification.style.opacity = '0'

  setTimeout(() => {
    notification.style.display = 'none'
  }, 2600)
})
