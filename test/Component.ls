require! {
  assert
  \../ls/Component
}

_it = it

describe 'new Component' !->
  c = new Component

  describe ".template!" !->
    _it "should return ''" !->
      assert.equal '', c.template!

  describe ".attach!" !->
    _it "should return void" !->
      assert.equal void, c.attach!

  describe ".detach!", !->
    _it "should return void" !->
      assert.equal void, c.detach!

  describe ".state!", !->
    _it "should return {}" !->
      assert.deep-equal {}, c.state!

describe 'new Component {foo: "bar"}' !->
  describe 'stub', !->
    _it 'stub2' !->
      assert.equal 'my ass', 'my ass'
