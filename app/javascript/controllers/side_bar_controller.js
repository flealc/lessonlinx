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
    const isHidden = this.collapsibleListTarget.hidden;
    this.collapsibleListTarget.hidden = !isHidden;
    this.toggleContentArea(isHidden);
    this.toggleIcon(isHidden ? "fa-angles-right" : "fa-angles-left", isHidden ? "fa-angles-left" : "fa-angles-right")
  }

  toggleFullPage() {
    const isHidden = this.collapsibleListTarget.hidden
    this.collapsibleListTarget.hidden = !isHidden
    this.toggleContentArea(isHidden, true)
    this.toggleIcon(isHidden ? "fa-angles-right" : "fa-angles-left", isHidden ? "fa-angles-left" : "fa-angles-right")
  }

  toggleContentArea(isListHidden, fullPage = false) {
    const colSizes = fullPage ? ["col-9", "col-12", "col-sm-10", "col-sm-12"] : ["col-9", "col-12", "col-sm-8", "col-sm-10"]
    this.contentAreaTarget.classList.replace(isListHidden ? colSizes[1] : colSizes[0], isListHidden ? colSizes[0] : colSizes[1])
    this.contentAreaTarget.classList.replace(isListHidden ? colSizes[3] : colSizes[2], isListHidden ? colSizes[2] : colSizes[3])
  }

  toggleIcon(oldIcon, newIcon) {
    this.toggleIconTarget.classList.replace(oldIcon, newIcon)
  }

}
