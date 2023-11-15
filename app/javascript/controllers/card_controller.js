import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = [
    "expandCardArrow",
    "cardBody",
    "cardTitleBar"
  ]

  expandCard() {
    this.cardBodyTarget.classList.add("show")
    this.expandCardArrowTarget.classList.replace('fa-angle-down', 'fa-angle-up')
    this.cardTitleBarTarget.setAttribute('data-action', 'click->card#collapseCard')
    
  }
  
  collapseCard() {
    this.cardBodyTarget.classList.remove("show")
    this.expandCardArrowTarget.classList.replace('fa-angle-up', 'fa-angle-down')
    this.cardTitleBarTarget.setAttribute('data-action', 'click->card#expandCard')
  }


}
