import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="side-bar"
export default class extends Controller {
  static targets = [
    "collapsibleList",
    "toggleIcon",
    "contentArea"
  ]
  connect() {}

  toggle() {
    this.collapsibleListTarget.hidden = !this.collapsibleListTarget.hidden

    if (this.collapsibleListTarget.hidden) {
      this.contentAreaTarget.classList.replace("col-9", "col-12")
      this.contentAreaTarget.classList.replace("col-sm-7", "col-sm-9")
      this.toggleIconTarget.classList.replace("fa-angle-left", "fa-angle-right")
    } else {
      this.contentAreaTarget.classList.replace("col-12", "col-9")
      this.contentAreaTarget.classList.replace("col-sm-9", "col-sm-7")
      this.toggleIconTarget.classList.replace("fa-angle-right", "fa-angle-left")
    }
  }

  toggleFullPage() {
   
    this.collapsibleListTarget.hidden = !this.collapsibleListTarget.hidden

    if (this.collapsibleListTarget.hidden) {
      this.contentAreaTarget.classList.replace("col-9", "col-12")
      this.contentAreaTarget.classList.replace("col-sm-10", "col-sm-12")
      this.toggleIconTarget.classList.replace("fa-angle-left", "fa-angle-right")
    } else {
      this.contentAreaTarget.classList.replace("col-12", "col-9")
      this.contentAreaTarget.classList.replace("col-sm-12", "col-sm-10")
      this.toggleIconTarget.classList.replace("fa-angle-right", "fa-angle-left")
    }
    
  }

}
