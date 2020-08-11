import { Controller } from 'stimulus'
import flatpickr from 'flatpickr'

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      defaultDate: this.datePicked()
    })
  }

  datePicked() {
    const publishedDate = this.element.dataset.publishedDate

    if (publishedDate) {
      return publishedDate
    }

    return new Date()
  }
}
