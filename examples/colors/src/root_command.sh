message=${args[message]:-hello colors}

underlined "Message Received":
echo
echo "  => $(green_bold "$message")"
echo "  ==> $(red_bold "$message")"
echo "  ===> $(blue_bold "$message")"
echo
