import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="digest-signup"
export default class extends Controller {
  static targets = [
    "signupSwitch",
    "deliverAtGroup",
    "deliverAtField",
    "copyButton",
  ]
  static values = {
    signedup: String,
    link: String,
  }

  connect() {
    if (this.signedupValue === "true") {
      this.signupSwitchTarget.checked = true
    }

    this.toggleDigest()
  }

  copyLink() {
    navigator.clipboard.writeText(this.linkValue)
    this.copyButtonTarget.innerHTML =
      '<i class="fa-regular fa-clipboard fa-bounce" style="--fa-animation-iteration-count: 1;"></i>'
  }

  toggleDigest() {
    if (this.signupSwitchTarget.checked) {
      this.deliverAtGroupTarget.style.display = "block"
    } else {
      this.deliverAtGroupTarget.style.display = "none"
      this.deliverAtFieldTarget.value = ""
    }
  }
}
