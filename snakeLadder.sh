#!/bin/bash -x
tput clear
ladder+=( "4" "9" "20" "28" "40" "52" "63" "74" )
snake+=( "3" "17" "35" "45" "54" "62" "87" "93" "95" "99" )
echo "GAME IS STARTTING"
echo "Number of players u want to play"
read player
echo "Game Starts"
echo "all $player players are at 0 now"

function die()
{
	dieValue=$((RANDOM%6 + 1))
	echo ""
	echo "the die value is $dieValue"
}

function ladderCheck()
{
for value in ${ladder[@]}
do
	if(($value==$start))
	then
		echo "the player$playerNumber is at $start"
		echo "you got a ladder"
		start=`expr $start + $dieValue`
		echo "the player$playerNumber is at $start"
		break
	fi
done
}

function snakeCheck()
{
for value in ${snake[@]}
do
	if(($value==$start))
	then
		echo "the player$playerNumber is at $start"
		start=`expr $start - $dieValue`
		start=`expr $start - $dieValue`
		echo "you got a snake"
		echo "the player$playerNumber is at $start"
		break
	fi
done
}

for((playerNumber=1;playerNumber<=player;playerNumber++))
do
start=0
dieCount=0
echo "-------------------------------------"
echo "starting game for player $playerNumber"
sleep 2
while(($start<101))
do
	let "dieCount=dieCount+1"
	die
	start=`expr $start + $dieValue`
	newStart=$start
	ladderCheck
	snakeCheck
	if(($newStart==$start))
	then
		echo "you dont get any snake or ladder"
		echo "you are in no play condition"
		echo "player$playerNumber is at $start now"
	fi
	if(($start<0))
	then
		start=0
		echo "player$playerNumber is at $start"
	elif(($start>100))
	then
		start=`expr $start - $dieValue`
		echo "player$playerNumber is at same position $start"
	elif(($start==100))
	then
		echo "die is rolled $dieCount times"
		echo "player$playerNumber game is over"
		sleep 2
		break
	fi
done
players+=( "$dieCount" )
done

echo "--------------------------------------------"
echo "for $player players after finishing the game"
echo "each player rolled the die this much time for completing the game respectively"
echo "${players[@]}"
sleep 2

winner=( $( printf "%s\n" "${players[@]}" | sort -n ) )
echo "$winner is the winner player die rolled"
for((check=0;check<$player;check++))
do
	if(($winner == ${players[check]}))
	then
		echo "winner is player `expr $check + 1`"
	fi
done

