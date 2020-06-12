#!/bin/bash -x
ladder+=( "4" "9" "20" "28" "40" "52" "63" "74" )
snake+=( "3" "17" "35" "45" "54" "62" "87" "93" "95" "99" )
tput clear
echo "GAME IS STARTING"
start1=0
start2=0
echo "Game Starts"
echo "player 1 is at $start1 now"
echo "player 2 is at $start2 now"

function die()
{
	dieValue=$((RANDOM%6 + 1))
	echo "the die value is $dieValue"
}

function ladderCheck()
{
for value in ${ladder[@]}
do
	if(($value==$start1))
	then
		echo "the player 1 is at $start1"
		echo "you got a ladder"
		start1=`expr $start1 + $dieValue`
		echo "the player 1 is at $start1"
		break
	fi
	if(($value==$start2))
        then
		echo "the player 2 is at $start2"
                echo "you got a ladder"
                start2=`expr $start2 + $dieValue`
                echo "the player 2 is at $start2"
                break
        fi

done
}

function snakeCheck()
{
for value in ${snake[@]}
do
	if(($value==$start1))
	then
		echo "the player 1 is at $start1"
		start1=`expr $start1 - $dieValue`
		start1=`expr $start1 - $dieValue`
		echo "you got a snake"
		echo "the player 1 is at $start1"
		break
	fi
	if(($value==$start2))
        then
                echo "the player 2 is at $start2"
                start2=`expr $start2 - $dieValue`
                start2=`expr $start2 - $dieValue`
                echo "you got a snake"
                echo "the player 2 is at $start2"
                break
        fi
done
}

dieCount1=0
dieCount2=0

while(($start1<101 || $start2<101))
do
	sleep 0.5
	echo "-------------------------------------------FOR PLAYER 1------------------------------------------------------"
	let "dieCount1=dieCount1+1"
	die
	start1=`expr $start1 + $dieValue`
	newStart1=$start1
	ladderCheck
	snakeCheck
	if(($newStart1==$start1))
	then
		echo "you dont get any snake or ladder"
		echo "you are in no play condition"
		echo "player 1 is at $start1 now"
	fi
	if(($start1<0))
	then
		start1=0
		echo "player 1 is at $start1"
	elif(($start1>100))
	then
		start1=`expr $start1 - $dieValue`
		echo "player 1 is at same position $start1"
	elif(($start1==100))
	then
		echo "die is rolled $dieCount1 times for player 1"
		echo "player 1 wins"
		exit
	fi
	sleep 0.5
	echo "--------------------------------------------FOR PLAYER 2------------------------------------------------------"
	let "dieCount2=dieCount2+1"
	die
	start2=`expr $start2 + $dieValue`
	newStart2=$start2
	ladderCheck
	snakeCheck
	if(($newStart2==$start2))
	then
		echo "you dont get any snake or ladder"
		echo "you are in no play condition"
		echo "player 2 is at $start2 now"
	fi
	if(($start2<0))
	then
		start2=0
		echo "player 2 is at $start2"
	elif(($start2>100))
	then
		start2=`expr $start2 - $dieValue`
		echo "player 2 is at same position $start2"
	elif(($start2==100))
	then
		echo "die is rolled $dieCount2 times for palyer 2"
		echo "player 2 wins"
		exit
	fi
done

