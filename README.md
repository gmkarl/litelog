= Litelog =

Frustrated with issues running more complex logging systems, I have created 'litelog'.
Litelog is a modular system for recording and logging data, for security, research, or
anything else you can think of.  It is intended to be secure, easy to use, and easy to
make small contributions to.  Please fork widely.

Litelog is not tied to any particular programming language or data storage representation.
The assumption is that if a new way of doing things is introduced, any differences are
modularized out, such that one, the other, or both may be used if desired.

Litelog is broken into a set of small components, none of which rely on each other.
Hence some small portion may be used without requiring inclusion of the others, and
managed, debugged, and developed individually.

The current setup for litelog after install is:
- /etc/litelog contains local customizations
- LITELOGDIR (/usr/lib/litelog) contains all litelog scripts and defaults
  - Current subfolder layout is <language_or_platform>/<module>
  - Ideally a makefile in the root of each language_or_platform subfolder installs loggers
    for all supported datatypes.
- LOGDIR (/var/lib/litelog) is a git repository (or subfolder) containing log files
  - git is used to allow for easy cryptographic verification of the integrity of the logs
  - Currently the only data storage paradigm is flat mkv files.
    The format is <module>/<date>_<hostname>_<device>_<compression>.mkv .
    Feel free to expand what is stored here.  Nobody is yet relying on it.

New modules should be placed in an appropriate subfolder, and provided a README.md file
which describes what they do.

= Concerns =
The use of git results in data duplication on commit.  If this is a problem, I would
encourage the creation of scripts to manage this.
- Committed files may be freely deleted from LOGDIR.  They are still kept in the git history.
- Old unneeded logs may be deleted from both the git history and LOGDIR, by wiping the object
  from the tree.
  [ ] TODO: a solution is needed allowing unneeded history to be cleaned up without causing
            git fsck to fail, but still allowing verification of data integrity vs. a
            historical git hash.  Perhaps git is not the best tool here, or perhaps a mechanism
            can be found to provide for this.
