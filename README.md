AmberMdPrep
===========

Wrapper script for preparing explicitly solvated systems for molecular dynamics simulations with Amber.

Implements the protocol found in the following publication: https://doi.org/10.1063/5.0013849

Note that the script is still a BETA version. Use at your own risk.

Documentation
=============
```
Command line options
  -i <file>            : File containing minimization steps.
  -p <file>            : Topology (required)
  -c <file>            : Coordinates (required)
  --temp <temp>        : Temperature (required)
  --thermo <type>      : Thermostat: berendsen (default), langevin
  --baro <type>        : Barostat: berendsen (default), montecarlo
  --finalthermo <type> : Final stage thermostat: berendsen, langevin (default)
  --finalbaro <type>   : Final stage barostat: berendsen, montecarlo (default)
  --nsolute <#>        : Number of solute residues.
  --type <type>        : Residues type {protein* | nucleic}; determines backbone mask.
  --mask <mask>        : Additional mask to use for restraints during steps 1-8.
  --ares <name>        : Residue name to add to heavy atom masks if present.
  --pmask <mask>       : Restraint mask to use during "production" (steps 9 and above).
  --pwt <weight>       : Restraint weight to use for '--pmask'; required if '--pmask' specified.
  --pref <file>        : Optional reference structure to use for '--pmask'.
  --charmmwater        : If specified assume CHARMM water (i.e. 'TIP3').
  --cutoff <cut>       : If specified, override default cutoffs with <cut>.
  --test               : Test only. Do not run.
  --norestart          : Do standard Eq with no restarts.
  --evaltype <type>    : <type = {script|cpptraj} Evaluate with EvalEquilibration.sh or cpptraj.
                         If this is not specified, final density eq. (step 10) will be skipped.
  --nprocs <#>         : Number of CPU processes to use (default 4).
  -O                   : Overwrite existing files, otherwise skip.
  --keyhelp            : Print help for recognized input file keys.
  --statusfile <file>  : Status file for final density eq.
Environment vars
  PROG_MIN : Command for minimization steps.
  PROG_MD  : Command for MD steps.
```
