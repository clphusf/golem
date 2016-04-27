local function run(msg)
if msg.text == "!nano" then
	return "فرستادم تو پي وي "
end
if msg.text == "!cd $HOME" then
	return "به پوشه اصلي برگشتي"
end
if msg.text == "!cd " then
	return "وارد شدي"
end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
    "^!cd",
	"^!nano",
    "^!cd $HOME$",
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}

