import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-fields"
export default class extends Controller {
  static targets = [ "textField", "fileField", "preview"]

  connect() {
    console.log("Connect.");
    this.displayPreview();
  }

  fileFieldManager() {
    console.log("File Field Manager");
    this.displayPreview();
  }

  textFieldManager() {
    console.log("Text Field Manager");
  }


  // Getters

  get url() {
    return this.textFieldTarget.value
  }

  get file() {
    return this.fileFieldTarget.value
  }

  get preview() {
    return this.previewTarget
  }

  // Functions

  displayPreview() {
    let input = this.fileFieldTarget;
    if (input) {
        let files = input.files;
        let img = this.previewTarget;
        let reader = new FileReader();
    
        reader.onload = function() {
          img.src = reader.result;
        }
    
        reader.readAsDataURL(files[0]);
        img.style.display = "block";
      }
    }
}
