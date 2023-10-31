import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="students-index"
export default class extends Controller {

  static targets = ["expandCardArrow", "contactCardBody", "modal"]
  connect() {
  }

  expandCard() {
    this.contactCardBodyTarget.classList.add("show")
    this.expandCardArrowTarget.outerHTML = "<i class='fa-solid fa-angle-up' data-students-index-target='expandCardArrow' data-action='click->students-index#collapseCard'></i>"
  }

  collapseCard() {
    this.contactCardBodyTarget.classList.remove("show")
    this.expandCardArrowTarget.outerHTML = "<i class='fa-solid fa-angle-down' data-students-index-target='expandCardArrow' data-action='click->students-index#expandCard'></i>"
  }
  
  open(event) {
    event.preventDefault();
    
    this.modalTarget.showModal();
  }

  close(event) {
    event.preventDefault();

    this.modalTarget.close()
    
    
  }

}
