import { Controller } from "@hotwired/stimulus"
import Trix from "trix"

// Connects to data-controller="trix"
export default class extends Controller {
  connect() {
    // Custom Trix underline button
    const UNUSED_TOOLBAR_CLASSES = [".trix-button-group--file-tools"]

    // inside the 'trix-initialize' event listener
    UNUSED_TOOLBAR_CLASSES.forEach((cls) => {
      document.querySelector(cls).remove()
    })

    Trix.config.textAttributes.underline = {
      tagName: "u",
      inheritable: true,
      parser: function (element) {
        var wrappedText = document.createElement("u")
        wrappedText.innertext = element
        return wrappedText
      },
    }

    Trix.config.textAttributes.title = {
      tagName: "h1",
      inheritable: true,
    }
    var groupElement = document.querySelector(
      ".trix-button-group.trix-button-group--text-tools"
    )
    groupElement.insertAdjacentHTML(
      "beforeend",
      '<button type="button" class="trix-button trix-button--icon trix-button--icon-underline" data-trix-attribute="underline"><sub>Underline</sub></button>'
    )
  }
}
