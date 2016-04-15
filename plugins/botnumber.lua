do

function run(msg, matches)
send_contact(get_receiver(msg), "+989378914486", "AVIRABOT", ".", ok_cb, false)
end

return {
patterns = {
"^[#/!]([Bb]otnumber)$"

},
run = run
}

end
