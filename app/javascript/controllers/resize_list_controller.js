import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resize-list"
export default class extends Controller {
  connect() {
    console.log("Hello controller")
  }

}
