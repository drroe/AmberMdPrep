AmberMdPrep
===========

Wrapper script for preparing explicitly solvated systems for molecular dynamics simulations with Amber.

Implements the protocol found in the following publication: https://doi.org/10.1063/5.0013849

Note that the script is still a BETA version. Use at your own risk.

Requires AmberTools and the GitHub version of [CPPTRAJ](https://github.com/Amber-MD/cpptraj).

Author
======
Daniel R. Roe (<daniel.r.roe@gmail.com>)
Laboratory of Computational Biology
National Heart Lung and Blood Institute
National Institutes of Health, Bethesda, MD.

Documentation
=============

The most basic usage requires an Amber topology file (`-p`), initial coordinates (`-c`), and
a target temperature (`--temp`).

```
Command line options
 Required:
  -p <file>            : Topology (required)
  -c <file>            : Coordinates (required)
  --temp <temp>        : Temperature (required)
 Optional:
  -i <file>            : File containing custom minimization steps (optional).
  --thermo <type>      : Thermostat: berendsen, langevin (default)
  --baro <type>        : Barostat: berendsen, montecarlo (default)
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
