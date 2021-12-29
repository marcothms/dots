killall -q polybar

for mon in $(xrandr | grep 'connected' | awk '{print $1}'):
do
	echo ${mon}
	MON=${mon} polybar -r bar &
done
