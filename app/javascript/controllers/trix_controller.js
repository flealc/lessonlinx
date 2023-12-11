import { Controller } from "@hotwired/stimulus"
import Trix from "trix"


// Add custom Trix toolbar buttons
Trix.config.textAttributes.underline = {
  tagName: "u",
  inheritable: true,
}

Trix.config.textAttributes.title = {
  tagName: "h1",
  inheritable: true,
}

export default class extends Controller {
  connect() {
    
    // Remove Trix toolbar buttons for attachments
    const UNUSED_TOOLBAR_CLASSES = [".trix-button-group--file-tools"]

    UNUSED_TOOLBAR_CLASSES.forEach((cls) => {
      document.querySelector(cls).remove()
    })

    var groupElement = document.querySelector(
      ".trix-button-group.trix-button-group--text-tools"
    )
    groupElement.insertAdjacentHTML(
      "beforeend",
      '<button type="button" class="trix-button trix-button--icon trix-button--icon-underline" data-trix-attribute="underline"><sub>Underline</sub></button>'
    )
  }
}
