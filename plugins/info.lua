do
function run(msg, matches)
  return "🔱group ID : "..msg.from.id.."\n🔱group name : "..msg.to.title.."\n🔱your name : "..(msg.from.first_name or '').."\n🔱first : "..(msg.from.first_name or '').."\n🔱last : "..(msg.from.last_name or '').."\n🔱user ID : "..msg.from.id.."\n🔱username : @"..(msg.from.username or '').."\n🔱phone number : +"..(msg.from.phone or '')
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[!/#]info$",
  },
  run = run
}
end

