import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "closeable" ]

  close() {
    this.element.classList.add(...[ "transition-opacity", "ease-in-out", "delay-50", "duration-200", "opacity-0" ])
    setTimeout(() => {
      this.element.classList.add('hidden');
    }, 200);
  }
}
