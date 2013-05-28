require! assert

_it = it # HACK! lol

describe 'Array', ->
  describe '#indexOf()', ->
    _it 'should return -1 when the value is not present', ->
      assert.equal -1, [ 1 2 3 ].indexOf 5
      assert.equal -1, [ 1 2 3 ].indexOf 0
