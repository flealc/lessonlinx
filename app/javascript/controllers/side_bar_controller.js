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
      this.toggleIconTarget.outerHTML =
        "<i class='fa-solid fa-angle-right' data-side-bar-target='toggleIcon' data-action='click->side-bar#toggle'></i>"
    } else {
      this.contentAreaTarget.classList.replace("col-12", "col-9")
      this.contentAreaTarget.classList.replace("col-sm-9", "col-sm-7")
      this.toggleIconTarget.outerHTML =
        "<i class='fa-solid fa-angle-left' data-side-bar-target='toggleIcon' data-action='click->side-bar#toggle'></i>"
    }
  }

  toggleFullPage() {
   
    this.collapsibleListTarget.hidden = !this.collapsibleListTarget.hidden

    if (this.collapsibleListTarget.hidden) {
      this.contentAreaTarget.classList.replace("col-9", "col-12")
      this.contentAreaTarget.classList.replace("col-sm-10", "col-sm-12")
      this.toggleIconTarget.outerHTML =
        "<i class='fa-solid fa-angle-right' data-side-bar-target='toggleIcon' data-action='click->side-bar#toggleFullPage'></i>"
    } else {
      this.contentAreaTarget.classList.replace("col-12", "col-9")
      this.contentAreaTarget.classList.replace("col-sm-12", "col-sm-10")
      this.toggleIconTarget.outerHTML =
        "<i class='fa-solid fa-angle-left' data-side-bar-target='toggleIcon' data-action='click->side-bar#toggleFullPage'></i>"
    }
    
  }

}
