import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-contact"
export default class extends Controller {
  
  static targets = ["relationshipField", "selfCheckbox", "relationshipDiv", "firstNameField", "lastNameField", "firstNameDiv", "lastNameDiv"]
  static values = {
    first: String,
    last: String
  }

  
  connect() {
    this.toggleSelf()
  }



  toggleSelf() {
    if (this.selfCheckboxTarget.checked) {
      this.relationshipDivTarget.style.display = "none"
      this.firstNameDivTarget.style.display = "none"
      this.lastNameDivTarget.style.display = "none"

      this.relationshipFieldTarget.value = "self"
      this.firstNameFieldTarget.value = this.firstValue
      this.lastNameFieldTarget.value = this.lastValue
    } else {
      this.relationshipFieldTarget.value = ""
      this.firstNameFieldTarget.value = ""
      this.lastNameFieldTarget.value = ""

      this.relationshipDivTarget.style.display = "block"
      this.firstNameDivTarget.style.display = "block"
      this.lastNameDivTarget.style.display = "block"
    }

  }

  
}
