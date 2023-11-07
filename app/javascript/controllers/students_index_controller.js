import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="students-index"
export default class extends Controller {
  static targets = [
    "expandCardArrow",
    "contactCardBody",
    "studentsList",
    "studentDetails",
    "toggleIcon",
    "checkbox",
  ]
  connect() {}

  expandCard() {
    this.contactCardBodyTarget.classList.add("show")
    this.expandCardArrowTarget.outerHTML =
      "<i class='fa-solid fa-angle-up' data-students-index-target='expandCardArrow' data-action='click->students-index#collapseCard'></i>"
  }

  collapseCard() {
    this.contactCardBodyTarget.classList.remove("show")
    this.expandCardArrowTarget.outerHTML =
      "<i class='fa-solid fa-angle-down' data-students-index-target='expandCardArrow' data-action='click->students-index#expandCard'></i>"
  }


  allSelected = false

  selectAll(event) {
    if (!this.allSelected) {
      this.checkboxTargets.forEach((checkbox) => {
        checkbox.checked = true
      })
    } else {
      this.checkboxTargets.forEach((checkbox) => {
        checkbox.checked = false
      })
    }

    this.allSelected = !this.allSelected
  }


}
