# unbind reactive function
export r-unbind = !(rf) ->
  for d in rf.dependencies
    d.remove-dependent!

