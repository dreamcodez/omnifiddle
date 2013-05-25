require! {
  connect
  express
}

const max-age = 0ms

export run = (path = process.cwd!, port = 8000) ->
  express!
    ..use express.static(path, {max-age})
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..listen port
