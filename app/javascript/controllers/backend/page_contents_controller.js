import { Controller } from 'stimulus'

export default class extends Controller {

  static get targets() {
    return [ 'fields' ]
  }

  select_style(event) {
    const templateName = event.target.selectedOptions[0].value
    const template = document.getElementById(templateName)
    const wrapper = this.fieldsTarget

    wrapper.innerHTML = template.innerHTML
  }
}
