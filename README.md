<!-- Utility for persisting directories between multiple runs of one-off Virtual Machines.

Usage: casher COMMAND [ARGS,..]

Available commands:
  add PATH,..           reads given paths from archive, if available, tracks them
  fetch URLS,..         tries to download the archive from given URLs
  pack                  generate a new archive (called by push if one of the paths changed)
  push URL              if any of the tracked paths changed, packs archive and pushes to URL
  reset                 removes archives, checksums and stops tracking paths (called by fetch)
  reset-headers         drops headers set via set-header
  set-header KEY VALUE  adds a header to all HTTP requests

Requirements:

- Ruby 1.9.3 or later, including standard library (shellwords and fileutils)
- [md5deep](http://md5deep.sourceforge.net/) -->