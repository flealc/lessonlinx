import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="students-index"
export default class extends Controller {

  static targets = ["expandCardArrow", "contactCardBody", "studentsList", "studentDetails", "toggleIcon"]
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
  
  toggle() {
   
    this.studentsListTarget.hidden = !this.studentsListTarget.hidden

    if (this.studentsListTarget.hidden) {
      this.studentDetailsTarget.classList.replace("col-9", "col-12")
      this.studentDetailsTarget.classList.replace("col-sm-10", "col-sm-12")
      this.toggleIconTarget.outerHTML = "<i class='fa-solid fa-angle-right' data-students-index-target='toggleIcon' data-action='click->students-index#toggle'></i>"
    } else {
      this.studentDetailsTarget.classList.replace("col-12", "col-9")
      this.studentDetailsTarget.classList.replace("col-sm-12", "col-sm-10")
      this.toggleIconTarget.outerHTML = "<i class='fa-solid fa-angle-left' data-students-index-target='toggleIcon' data-action='click->students-index#toggle'></i>"
    }  
    
  }


}
