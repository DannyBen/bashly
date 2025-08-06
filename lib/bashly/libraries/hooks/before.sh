## before hook
##
## Any code here will be placed inside a `before_hook()` function and called
## before running any command (but after processing its arguments).
##
## - The processed args are available to you here as `$args` and `$extra_args`
## - The raw input array is also available in read-only mode as `$input`
##
## You can safely delete this file if you do not need it.
echo "==[ Before Hook Called ]=="
inspect_args