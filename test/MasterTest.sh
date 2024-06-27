# All tests should source this. Provide common functionality

TESTCOUNT=0
ERRCOUNT=0
RUNCOUNT=0
FAILCOUNT=0
TEST_OUTPUT='test.out'

# CleanFiles() <file1> ... <fileN>
#   For every arg passed to the function, check for the file or directory and
#   remove it.
CleanFiles() {
  while [ ! -z "$1" ] ; do
    if [ -d "$1" ] ; then
      rmdir $1
    elif [ -f "$1" ] ; then
      rm $1
    fi
    shift
  done
}

CleanFiles $TEST_OUTPUT *.diff

# Parse test options
CLEAN=0
while [ ! -z "$1" ] ; do
  case "$1" in
    'clean' ) CLEAN=1 ;;
  esac
  shift
done

# Run Test
RunTest() {
  # If cleaning, just exit now
  if [ $CLEAN -eq 1 ] ; then
    exit 0
  fi
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
  # Allow -I <something> for 3 and 4. Ignore whitespace.
  diff -w $FILE1 $FILE2 $3 $4 > temp.diff
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
  if [ $ERRCOUNT -gt 0 ] ; then
    echo "$ERRCOUNT of $TESTCOUNT comparisons failed."
    echo "$OKCOUNT of $TESTCOUNT comparisons passed."
  else
    echo "All $TESTCOUNT comparisons passed."
  fi
  echo ""
  exit $ERRCOUNT
}

