import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.inputTarget.focus()
  }

  submitForm() {
    if (this.inputTarget.disabled) return

    this.element.requestSubmit()
    this.inputTarget.disabled = true
  }
}
