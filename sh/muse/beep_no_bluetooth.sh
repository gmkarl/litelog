#!/bin/sh

if [ -e /etc/litelog ]
then
	. /etc/litelog
	. "$LITELOGDIR"/sh/functions
fi

pcspkr_beep()
{
	beep
}

alsa_beep()
{
	beep_samples=8000
	beep_hertz=800
	samples_per_period=$((8000/beep_hertz))
	periods_per_beep=$((beep_samples/samples_per_period))
	for ((p=0; p<periods_per_beep; ++p))
	do
		for ((s=0; s<samples_per_period/2; ++s))
		do
			printf "\xff"
		done
		for ((s=0; s<samples_per_period/2; ++s))
		do
			printf "\x00"
		done
	done | aplay -
}

# beep if no incoming bluetooth packets
A="$(hciconfig|grep RX)"
while true
do
  sleep 1
  B="$(hciconfig|grep RX)"
  if [ "$A" == "$B" ]
  then
    alsa_beep
    hciconfig
  fi
  A="$B"
done
