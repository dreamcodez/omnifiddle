require! {
  cj : '../build/clientjade.js'
}

window.foo = 69

window <<< {cj}

