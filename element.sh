#!/bin/bash

# echo $1

INPUT=$1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

# check if $1 is number
if [[ $INPUT =~ ^[0-9]+$ ]] 
then
  ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $INPUT;")
  if [[ ! -z $ELEMENT_DETAILS ]]
  then
    echo "$ELEMENT_DETAILS" | while read TYPE_ID BAR ATOMIC_ID BAR SYMBOL BAR NAME BAR MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
    do
    echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
# check if $1 is 1 or character text
elif [[ ${#INPUT} =~ [12] ]] 
then
  ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$INPUT';")
  if [[ ! -z $ELEMENT_DETAILS ]]
  then
    echo "$ELEMENT_DETAILS" | while read TYPE_ID BAR ATOMIC_ID BAR SYMBOL BAR NAME BAR MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
    do
    echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
# check if $1 is full element name
elif [[ $INPUT =~ ^[A-Za-z]+ ]] 
then
  ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$INPUT';")
  if [[ ! -z $ELEMENT_DETAILS ]]
  then
    echo "$ELEMENT_DETAILS" | while read TYPE_ID BAR ATOMIC_ID BAR SYMBOL BAR NAME BAR MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
    do
    echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
elif [[ -z $INPUT ]]
  then
  echo Please provide an element as an argument.
fi
