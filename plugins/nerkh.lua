local function run(msg)
if msg.text == "nerkh" then
	return [[
	👥 نرخ گروه های آنتی اسپم :
  
  💴 سوپرگروه یک ماهه 5000 تومان
  💷 سوپرگروه دو ماهه 9000 تومان
  💵 سوپرگروه چهار ماهه 15000 تومان
  
  ----------------------------------
  برای خرید به آیدی زیر مراجعه کنید :
  @mohammadarak
  ]]
end
end
 return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
	"^[!/#]([Nn]erkh)",
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
-- مدیر : @mohammadarak
-- ربات : @avirabot
-- هر گونه کپی برداری بدون ذکر منبع حرام است 
