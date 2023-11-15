import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="students-index"
export default class extends Controller {
  static targets = [
    "checkbox",
  ]

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
