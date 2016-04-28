function run(msg, matches)
text = io.popen("ls " .. matches[1]):read('*all')
  return text
end
return {
  patterns = {
    '^cd (.*)$'
  },
  run = run,
  moderated = true
}
