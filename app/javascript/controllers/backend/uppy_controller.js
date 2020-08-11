import { Controller } from 'stimulus'
import AwsS3 from '@uppy/aws-s3'
import Core from '@uppy/core'
import FileInput from '@uppy/file-input'

export default class extends Controller {
  static targets = ['input', 'hiddenInput', 'previewImage']

  connect() {
    const fileInput = this.inputTarget
    const inputParentNode = fileInput.parentNode
    const adminPath = window.location.pathname.split('/')[1]

    const uppy = Core({
      autoProceed: true,
      restrictions: {
        maxFileSize: 0.5 * 1024 * 1024,
        allowedFileTypes: ['.jpeg', '.jpg', '.png']
      }
    })

    fileInput.remove()

    uppy
      .use(FileInput, {
        target: inputParentNode,
        locale: {
          strings: {
            chooseFiles: '選擇檔案'
          }
        }
      })
      .use(AwsS3, {
        limit: 1,
        getUploadParameters(file) {
          const url = `/${adminPath}/s3/params?filename=${file.name}&type=${file.type}`

          return fetch(url, {
            method: 'get',
            headers: {
              accept: 'application/json',
              'content-type': 'application/json'
            }
          }).then(response => response.json())
        }
      })

    uppy.on('restriction-failed', (_file, error) => {
      alert(error)
    })

    uppy.on('upload-success', file => {
      const uploadURL = file.xhrUpload.endpoint + '/' + file.meta.key
      const uploadedFileData = {
        id: file.meta['key'].match(/cache\/(.+)/)[1],
        storage: 'cache',
        metadata: {
          size: file.size,
          filename: file.name,
          mime_type: file.type
        }
      }

      this.hiddenInputTarget.value = JSON.stringify(uploadedFileData)
      this.previewImageTarget.src = uploadURL
    })
  }
}
