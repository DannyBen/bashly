message=${args[message]:-hello colors}

underlined "Message Recevied":
echo
echo "  => $(green_bold "$message")"
echo "  ==> $(red_bold "$message")"
echo "  ===> $(blue_bold "$message")"
echo
