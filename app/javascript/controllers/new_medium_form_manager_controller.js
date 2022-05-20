import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-medium-form-manager"
export default class extends Controller {
  static targets = [ "textField", "fileField", "preview", "fileCancelButton"]

// Connectors method

  connect() {
    let default_preview_image_src = this.preexisting_image_src(); // Get source for medium-contained-image on edit if exists.
    this.doFileCancelButton(default_preview_image_src);
    this.disableFields();
    this.displayImagePreview(default_preview_image_src);
  }

  onTextFieldUpdate() {
    this.disableFields();
    this.displayImagePreview();
  }

  onFileFieldUpdate() {
    let default_preview_image_src = this.preexisting_image_src(); // Get source for medium-contained-image on edit if exists.
    this.doFileCancelButton(default_preview_image_src);
    this.disableFields();
    this.displayImagePreview(default_preview_image_src);
  }

  reset() {
    this.element.reset();
    let default_preview_image_src = this.preexisting_image_src(); // Get source for medium-contained-image on edit if exists.
    this.doFileCancelButton(default_preview_image_src);
    this.disableFields();
    this.disableImagePreview(default_preview_image_src);
  }



// Functions

  // Get source for medium-contained-image on edit if exists.
  preexisting_image_src() {
    let preview_img = this.preview;
    if(preview_img.id == 'medium-contained-img') {
     return preview_img.src;
    }
    return;
  }

  // Display & give function to file cancel button when file selected.
  doFileCancelButton(default_preview_image_src) {
    if (this.file.value !== '') {
      this.fileCancelButton.style.display = 'block';
      this.fileCancelButton.addEventListener('click', () => {
        this.file.value = '';
        this.disableFields();
        this.disableImagePreview(default_preview_image_src);
        this.fileCancelButton.style.display = 'none';
      });
    } else {
      this.fileCancelButton.style.display = 'none';
    }
  }

  // disable file field if text field used or inverse
  disableFields() {
    let text_field = this.text
    let file_field = this.file

    if (text_field.value !== '') { // if text_field contains something, disable & clean file_field
      file_field.disabled = true;
      file_field.value = '';
    } else {
      file_field.disabled = false;
    }

    if (file_field.value !== '') { // if file_field contains something, disable & clean text_field
      text_field.disabled = true;
      text_field.value = '';
    } else {
      text_field.disabled = false;
    }
  }

  // Disable a preview of selected local image
  displayImagePreview(default_preview_image_src) {
    let file = this.file;
    let img = this.preview;

    if(file.value) { // Display local image if file selected.
      let reader = new FileReader();
      reader.onload = function() {
        img.src = reader.result;
      }
      reader.readAsDataURL(file.files[0]);
      img.style.display = "block";        
    }
  }

  // Replaces by default or removes preview image
  disableImagePreview(default_preview_image_src) {
    let img = this.preview;
    if(default_preview_image_src) {
      img.src = default_preview_image_src
      img.style.display = "block";
    } else {
      img.src = '';
      img.style.display = "none";
    }  
  }




// Getters

  get preview() {
    return this.previewTarget;
  }

  get text() {
    return this.textFieldTarget
  }

  get file() {
    return this.fileFieldTarget
  }

  get fileCancelButton() {
    return this.fileCancelButtonTarget
  }
}
