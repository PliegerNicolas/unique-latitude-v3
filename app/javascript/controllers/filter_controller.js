import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter"
export default class extends Controller {
  submit(_event) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 300)
  }
}
