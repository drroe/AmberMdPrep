# All tests should source this. Provide common functionality

TESTCOUNT=0
ERRCOUNT=0

DoTest() {
  ((TESTCOUNT++))
  FILE1=$1
  if [ ! -f "$FILE1" ] ; then
    >&2 echo "Error: Save file $FILE1 missing."
    ((ERRCOUNT++))
    return 1
  fi
  FILE2=$2
  if [ ! -f "$FILE2" ] ; then
    >&2 echo "Error: Test file $FILE2 missing."
    ((ERRCOUNT++))
    return 1
  fi
  diff $FILE1 $FILE2 > temp.diff
  if [ -s 'temp.diff' ] ; then
    echo "  $FILE1 $FILE2 are different. Check $FILE2.diff"
    ((ERRCOUNT++))
    mv temp.diff $FILE2.diff
    return 1
  else
    echo "  $FILE2 OK."
    ((OKCOUNT++))
    rm temp.diff
  fi
  return 0
}

EndTest() {
  echo ""
  echo "$ERRCOUNT of $TESTCOUNT comparisons failed."
  echo "$OKCOUNT of $TESTCOUNT comparisons passed."
  exit $ERRCOUNT
}

