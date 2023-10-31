import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resize-list"
export default class extends Controller {

  static targets = ["lessonsList", "lessonDetails", "listToggle"];

  connect() {
    document.documentElement.addEventListener("turbo:frame-load", () => {
      this.toggle()
    });
  }
  toggle() {
   
    this.lessonsListTarget.hidden = !this.lessonsListTarget.hidden

    if (this.lessonsListTarget.hidden) {
      this.lessonDetailsTarget.classList.replace("col-9", "col-12")
      this.lessonDetailsTarget.classList.replace("col-sm-7", "col-sm-9")
      this.listToggleTarget.innerText = "Show lessons"
    } else {
      this.lessonDetailsTarget.classList.replace("col-12", "col-9")
      this.lessonDetailsTarget.classList.replace("col-sm-9", "col-sm-7")
      this.listToggleTarget.innerText = "Hide lessons"
    }  
    
  }

}
