import { Controller } from 'stimulus'
import ClassicEditor from 'ckeditor5-custom-build/build/ckeditor.js'

export default class extends Controller {

  connect() {
    const uploadPath = this.data.get('uploadPath')
    const adminPath = window.location.pathname.split('/')[1]
    const token = document.querySelector('meta[name="csrf-token"]').content

    ClassicEditor.create(this.element, {
      simpleUpload: {
        uploadUrl: `/${adminPath}/ckeditor_upload/${uploadPath}`,
        headers: {
          'X-CSRF-TOKEN': token,
          'Accept': 'application/json'
        }
      }
    })
      .then(editor => {
        window.editor = editor
      })
      .catch(error => {
        console.error('There was a problem initializing the editor.', error)
      })
  }
}
