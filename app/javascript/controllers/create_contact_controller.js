import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-contact"
export default class extends Controller {
  
  static targets = ["relationshipField", "selfCheckbox", "relationshipDiv", "firstNameField", "lastNameField", "firstNameDiv", "lastNameDiv"]
  static values = {
    studentFirst: String,
    studentLast: String,
    contactFirst: String,
    contactLast: String,
    relationship: String
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
      this.firstNameFieldTarget.value = this.studentFirstValue
      this.lastNameFieldTarget.value = this.studentLastValue
    } else {
      this.relationshipFieldTarget.value = this.relationshipValue
      this.firstNameFieldTarget.value = this.contactFirstValue
      this.lastNameFieldTarget.value = this.contactLastValue

      this.relationshipDivTarget.style.display = "block"
      this.firstNameDivTarget.style.display = "block"
      this.lastNameDivTarget.style.display = "block"
    }

  }

  
}
