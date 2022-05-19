import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-fields"
export default class extends Controller {
  static targets = [ "textField", "fileField", "preview", "fileCancelButton"]

  connect() {
    console.log("Connect.");
    this.disableFields();
    this.doFileCancelButton();
  }

  fileFieldManager() {
    this.disableFields();
    this.doFileCancelButton();
  }

  textFieldManager() {
    this.disableFields();
  }


  // Getters

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

  get fileCancelButton() {
    return this.fileCancelButtonTarget
  }

  // Functions

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
        this.fileCancelButton.style.display = 'none';
      });
    } else {
      this.fileCancelButton.style.display = 'none';
    }
  }

  // displayPreview() {
  //   let input = this.fileFieldTarget;
  //   let files = input.files;
  //   let img = this.previewTarget;

  //   if (input.value !== '' ) {
  //     let reader = new FileReader();

  //     reader.onload = function() {
  //       img.src = reader.result;
  //     }
    
  //     reader.readAsDataURL(files[0]);
  //     img.style.display = "block";
  //   } else {
  //     img.style.display = "hidden";
  //   }
  // }

  // disableFields() {
  //   let text_field = this.textFieldTarget
  //   let file_field = this.fileFieldTarget
  //   if (text_field.value) {
  //     console.log("Occupied text field");
  //     file_field.value = '';
  //     this.previewTarget.style.display = "hidden";
  //   }
  //   if (file_field.value) {
  //     console.log("Occupied file field");
  //     text_field.value = '';
  //   }
  // }
}
