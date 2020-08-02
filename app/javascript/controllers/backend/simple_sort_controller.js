import { Controller } from 'stimulus'
import Rails from '@rails/ujs'
import Sortable from 'sortablejs'

export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: this.sort.bind(this)
    })
  }

  sort(event) {
    const formData = new FormData()
    const sortData = {
      id: event.item.dataset.id,
      position: event.newIndex + 1
    }

    formData.append('sort', JSON.stringify(sortData))

    Rails.ajax({
      type: 'PATCH',
      url: this.data.get('url'),
      data: formData
    })
  }
}
