Litelog
=======

Frustrated with issues running more complex logging systems, I have created 'litelog'.
Litelog is a modular system for recording and logging data, for surveillance, research, or
anything else you can think of.  It is intended to be secure, easy to use, and easy to
make small contributions to.  Please fork freely.

Litelog is not tied to any particular programming language or data storage representation.
The assumption is that if a new way of doing things is introduced, any differences are
modularized out, such that one, the other, or both may be used if desired.  Components
may support any subset of available approaches.

Litelog is broken into a set of small components, none of which require each other.
Hence any chosen small portion may be used without inclusion of the others, and
managed, debugged, and developed individually.

The result is hopefully an easy-to-use hodge-podge of tools that may be freely united into
arbitrary solutions.

The current setup for litelog after install is:
- /etc/litelog contains local customizations
  - must set LITELOGDIR for modules to find their resources
  - defaults are at the top of sh/functions
    - [ ] TODO: move this out of sh, make a defaults environment file
- LITELOGDIR (/usr/lib/litelog) contains all litelog scripts and defaults
  - Current subfolder layout is <language_or_platform>/<module>
  - Ideally a makefile in the root of each language_or_platform subfolder installs loggers
    for all supported modules.
- LOGDIR (/var/lib/litelog) contains logfiles
  - Currently the only data storage paradigm is flat mkv files optionally hashed with git.
    The format is <module>/<date>_<hostname>_<device>_<compression>.mkv where <compression> is
      'unprocessed', 'raw', or 'audiocodec_videocodec'.  'unprocessed' indicates a raw file that
      has not been successfully compressed yet.
    Feel free to expand what is stored here.  Nobody is yet relying on it.

New modules should be placed in an appropriate subfolder, and provided a README.md file
which describes what they do.

Concerns
--------

Modularizing things like systemd out results in interdependencies between modules, and requires
module authors to spend energy understanding the existing norms.  For ease of maintenance, this
should be minimized and norms must be documented.  This notably applies to the current makefile
install system, which needs documentation for new /sh/ modules.

The use of git results in data duplication on commit.  If this is a problem, I would
encourage the creation of scripts to manage this.
- Committed files may be freely deleted from LOGDIR.  They are still kept in the git history.
- Old unneeded logs may be deleted from both the git history and LOGDIR, by wiping the object
  from the tree, although this breaks fscsk !  There may be a way to 'mark' objects as missing
  and let fsck pass.
- [ ] A better solution is to use git-annex rather than plain git.
