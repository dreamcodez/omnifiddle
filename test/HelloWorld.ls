require! {
  assert
  \../ls/HelloWorld
}

_it = it

describe 'new HelloWorld' ->
  h = new HelloWorld

  describe ".html" ->
    markup = '<p>Hello, World</p>'

    _it "should be '#{markup}'" ->
      assert.equal h.html, markup

describe "new HelloWorld {name:'Matt'}" ->
  h = new HelloWorld {name: 'Matt'}

  describe ".html" ->
    markup = '<p>Hello, World</p> <strong>Matt</strong>'

    _it "should be '#{markup}'" ->
      assert.equal h.html, markup
