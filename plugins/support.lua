local function run(msg)
if msg.text == "linksp" then
	return "https://telegram.me/joinchat/C3mo0T0-T7X2zKl3LezANw"
end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
	"^[!/#]([Ll]inksp)",
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
-- مدیر : @mohammadarak
-- ربات : @avirabot
-- هر گونه کپی برداری بدون ذکر منبع حرام است 
