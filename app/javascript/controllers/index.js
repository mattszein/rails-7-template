// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
eagerLoadControllersFrom("components", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

// On page load or when changing themes, best to add inline in `head` to avoid FOUC
if (sessionStorage.getItem('lookbook') != 'true') {
if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches) && localStorage.lookbook != 'true') {
  document.documentElement.classList.add('dark')
} else {
  document.documentElement.classList.remove('dark')
}
}
