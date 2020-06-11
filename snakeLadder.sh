#!/bin/bash -x
echo "Welcome to Snake and Ladder Simulator "

tput clear
echo "    |100| |99| |98| |97| |96| |95| |94| |93| |92| |91|"
echo "		 S		     S	       S	       Welcome to Snake Ladder Simulator "
echo "------------------------------------------------------"
echo "    |81|  |82| |83| |84| |85| |86| |87| |88| |89| |90|"
echo "					  S		    		Instructions:"
echo "------------------------------------------------------"
echo "    |80|  |79| |78| |77| |76| |75| |74| |73| |72| |71|"
echo "					  L		    		1.Game start from 0"
echo "------------------------------------------------------"
echo "    |61|  |62| |63| |64| |65| |66| |67| |68| |69| |70|		2.Game must be completed when reached to 100"
echo "		 S    L					    "
echo "------------------------------------------------------		3.When ladder block is reached ((L))"
echo "    |60|  |59| |58| |57| |56| |55| |54| |53| |52| |51|		    player will move forward by no. of position recieved in die"
echo "					  S 	    L	    "
echo "------------------------------------------------------		4.When snake block is reached ((S))"
echo "    |41|  |42| |43| |44| |45| |46| |47| |48| |49| |50|		    player will move backward by no. of position recieved in die"
echo "				S			    "
echo "------------------------------------------------------		5.When there is no snake and ladder"
echo "    |40|  |39| |38| |37| |36| |35| |34| |33| |32| |31|		    it is no play condition in this player remain on its place"
echo "	   L		             S			    "
echo "------------------------------------------------------"
echo "    |21|  |22| |23| |24| |25| |26| |27| |28| |29| |30|		WISH LUCK FOR THE GAME"
echo "					       L	    			MAY THE BEST LUCK PLAYER WINS"
echo "------------------------------------------------------"
echo "    |20|  |19| |18| |17| |16| |15| |14| |13| |12| |11|"
echo "     L		   S				    "
echo "------------------------------------------------------"
echo "|0| |01|  |02| |03| |04| |05| |06| |07| |08| |09| |10|"
echo "                S    L                        L       "
echo "------------------------------------------------------"

ladder+=( "4" "9" "20" "28" "40" "52" "63" "74" )
snake+=( "3" "17" "35" "45" "54" "62" "87" "93" "95" "99" )

echo "Wait for 5 secs to see the board and read instructions"
sleep 5
tput clear

echo ""
echo "GAME IS STARTTING"
echo ""
echo "please wait........."
sleep 2

start1=0
start2=0
echo ""
echo "Game Starts"
echo ""
echo "player 1 is at $start1 now"
echo ""
echo "player 2 is at $start2 now"
echo ""
sleep 2

function die()
{
	dieValue=$((RANDOM%6 + 1))
	echo " "
	echo "the die value is $dieValue"
}

function ladderCheck1()
{
for value in ${ladder[@]}
do
	if(($value==$start1))
	then
		echo "-----------------------"
		echo ""
		echo "the player 1 is at $start1"
		echo "-----------------------"
		echo "you got a ladder"
		start1=`expr $start1 + $dieValue`
		echo "the player 1 is at $start1"
		echo "-----------------------"
		break
	fi
done
}

function ladderCheck2()
{
for value in ${ladder[@]}
do
	if(($value==$start2))
	then
		echo "-----------------------"
		echo ""
		echo "the player 2 is at $start2"
		echo "-----------------------"
		echo "you got a ladder"
		start2=`expr $start2 + $dieValue`
		echo "the player 2 is at $start2"
		echo "-----------------------"
		break
	fi
done
}

function snakeCheck1()
{
for value in ${snake[@]}
do
	if(($value==$start1))
	then
		echo "-----------------------"
		echo ""
		echo "the player 1 is at $start1"
		start1=`expr $start1 - $dieValue`
		start1=`expr $start1 - $dieValue`
		echo "-----------------------"
		echo "you got a snake"
		echo "the player 1 is at $start1"
		echo "-----------------------"
		break
	fi
done
}

function snakeCheck2()
{
for value in ${snake[@]}
do
	if(($value==$start2))
	then
		echo "-----------------------"
		echo ""
		echo "the player 2 is at $start2"
		start2=`expr $start2 - $dieValue`
		start2=`expr $start2 - $dieValue`
		echo "-----------------------"
		echo "you got a snake"
		echo "the player 2 is at $start2"
		echo "-----------------------"
		break
	fi
done
}

dieCount1=0
dieCount2=0

while(($start1<101 || $start2<101))
do

	echo "-------------------------------------------FOR PLAYER 1------------------------------------------------------"
	echo "press enter to roll the die"
	read enter

	let "dieCount1=dieCount1+1"
	die
	start1=`expr $start1 + $dieValue`
	newStart1=$start1
	ladderCheck1
	snakeCheck1
	if(($newStart1==$start1))
	then
		echo "-----------------------"
		echo "you dont get any snake or ladder"
		echo ""
		echo "you are in no play condition"
		echo ""
		echo "player 1 is at $start1 now"
		echo "-----------------------"
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
		echo "die is rolled $dieCount1 times"
		echo "player 1 wins"
		exit
	fi

	echo "--------------------------------------------FOR PLAYER 2------------------------------------------------------"
	echo "press enter to roll the die"
	read enter

	let "dieCount2=dieCount2+1"
	die
	start2=`expr $start2 + $dieValue`
	newStart2=$start2
	ladderCheck2
	snakeCheck2
	if(($newStart2==$start2))
	then
		echo "-----------------------"
		echo "you dont get any snake or ladder"
		echo ""
		echo "you are in no play condition"
		echo ""
		echo "player 2 is at $start2 now"
		echo "-----------------------"
	fi
	if(($start2<0))
	then
		start2=0
		echo "player 2 is at $start2"
	elif(($start2>100))
	then
		start2=`expr $start2 - $dieValue`
		echo "player 2 is at same position $start2"
		echo ""
	elif(($start2==100))
	then
		echo "die is rolled $dieCount2 times"
		echo "player 2 wins"
		exit
	fi

done

