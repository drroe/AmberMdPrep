#!/bin/bash

source ../MasterTest.sh

# Simple test
CleanFiles *.in

UNITNAME='Simple test'
RunTest -p ../tz2.ortho.parm7 -c ../tz2.ortho.rst7 --temp 300 --test

DoTest test.out.save test.out -I AmberMdPrep.sh
for ((i=1; i<10; i++)) ; do
  DoTest Save/step$i.in step$i.in
done
DoTest Save/final.1.in final.1.in

EndTest
