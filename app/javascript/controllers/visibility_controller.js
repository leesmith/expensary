import { Controller } from "@hotwired/stimulus"
import { leave, enter, toggle } from "el-transition"

export default class extends Controller {
  static targets = [ "hideable" ]

  showTargets() {
    this.hideableTargets.forEach(el => {
      enter(el)
      // el.hidden = false
    });
  }

  hideTargets() {
    this.hideableTargets.forEach(el => {
      leave(el)
      // el.hidden = true
    });
  }

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      // el.hidden = !el.hidden
      toggle(el)
    });
  }
}
