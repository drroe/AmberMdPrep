# All tests should source this. Provide common functionality

TESTCOUNT=0
ERRCOUNT=0
RUNCOUNT=0
FAILCOUNT=0
TEST_OUTPUT='test.out'

if [ -f "$TEST_OUTPUT" ] ; then
  rm $TEST_OUTPUT
fi

RunTest() {
  ((RUNCOUNT++))
  echo ""
  echo "TEST: $UNITNAME"
  ../../AmberMdPrep.sh $* > $TEST_OUTPUT
  if [ $? -ne 0 ] ; then
    ((FAILCOUNT++))
  fi
}

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
  # Allow -I <something> for 3 and 4
  diff $FILE1 $FILE2 $3 $4 > temp.diff
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
  if [ $FAILCOUNT -gt 0 ] ; then
    echo "$FAILCOUNT of $RUNCOUNT executions had an error."
  else
    echo "All $RUNCOUNT executions ran."
  fi
  echo "$ERRCOUNT of $TESTCOUNT comparisons failed."
  echo "$OKCOUNT of $TESTCOUNT comparisons passed."
  echo ""
  exit $ERRCOUNT
}

