import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-medium-form-manager"
export default class extends Controller {
  static targets = [ "textField", "fileField", "preview", "fileCancelButton"]

  // -- Actions --

  connect() {
    this.displayImagePreview();
    this.doFileCancelButton();
    this.disableFields();
  }

  fileFieldManager() {
    this.displayImagePreview();
    this.doFileCancelButton();
    this.disableFields();
  }

  textFieldManager() {
    this.disableFields();
  }

  reset() {
    this.element.reset();
    this.disableFields();
   }

  // -- Functions --

  // disable file field if text field used or inverse
  disableFields() {
    let text_field = this.text
    let file_field = this.file

    // if text_field contains something, disable & clean file_field
    if (text_field.value !== '') {
      file_field.disabled = true;
      file_field.value = '';
    } else {
      file_field.disabled = false;
    }

    // if file_field contains something, disable & clean text_field
    if (file_field.value !== '') {
      text_field.disabled = true;
      text_field.value = '';
    } else {
      text_field.disabled = false;
    }
  }
  
  // Display & give function to file cancel button when file selected.
  doFileCancelButton() {
    if (this.file.value !== '') {
      this.fileCancelButton.style.display = 'block';
      this.fileCancelButton.addEventListener('click', () => {
        this.file.value = '';
        this.disableImagePreview();
        this.disableFields();
        this.fileCancelButton.style.display = 'none';
      });
    } else {
      this.fileCancelButton.style.display = 'none';
    }
  }

  // Disable a preview of selected local image
  displayImagePreview() {
    let file = this.fileFieldTarget;
    let img = this.previewTarget;

    if (file.value !== '') {
      let reader = new FileReader();
      reader.onload = function() {
        img.src = reader.result;
      }
      reader.readAsDataURL(file.files[0]);
      img.style.display = "block";  
    }
  }

  // Hides and cleans the local image preview
  disableImagePreview() {
    let img = this.previewTarget;
    img.src = '';
    img.style.display = "none";  
  }

  // -- Getters --

  get text() {
    // get value in text_field
    return this.textFieldTarget
  }

  get file() {
    // get value in file_field
    return this.fileFieldTarget
  }

  get preview() {
    // get preview image
    return this.previewTarget
  }

  get setPreEditImage() {
    default_image = this.previewTarget;
  }

  get fileCancelButton() {
    return this.fileCancelButtonTarget
  }
}
