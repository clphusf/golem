do

function run(msg, matches)
send_contact(get_receiver(msg), "+989378914486", "Avira", "Bot", ok_cb, false)
end

return {
patterns = {
"^[!#/]([Bb]otnumber)$"

},
run = run
}

end
-- مدیر : @mohammadarak
-- ربات : @avirabot
-- هر گونه کپی برداری بدون ذکر منبع حرام است 
