do

function run(msg, matches)
 if is_sudo(msg) then
       return "You are my father"
            send_document(get_receiver(msg), "./data/sticker/sudo.webp ", ok_cb, false)
end

return {
patterns = {
"^![Mm]e$",

},
run = run
}

end
