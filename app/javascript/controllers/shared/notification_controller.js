import { Controller } from 'stimulus'

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 5000)
  }
}
