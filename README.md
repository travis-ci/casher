# CA$H€R

![](http://4.bp.blogspot.com/_XdP6Lp2ceqY/TEJuww2sk2I/AAAAAAAAWpY/EmWweRXahGM/s1600/tumblr_l55qcmER041qznd83o1_500.jpg)

## What Casher Does

Casher is a script used by [Travis Build](https://github.com/travis-ci/travis-build) to create, handle, and update caches. Travis Build generates a signature and URL and sends it to Casher. Casher checks the URL to see if there is an existing cache. If one is not found, it creates one. If one is found, it pulls the cache from S3 (Docker builds) or GCS (GCE and MacStadium builds) and expands it from the root of the OS. 

Travis Build can tell Casher to add the directories or shortcuts (bundler, pip) to the cache specified in a user's .travis.yml. Casher then runs md5deep which can recursively compute the MD5 for every file in a directory. Travis Build will then run `before_cache` specifications in a user's .travis.yml to remove files that could change the checksum and invalidate the cache. If the MD5 checksums are different, Casher will create a new cache and store it at the URL sent to it by Travis Build originally.

## Status

Casher is still actively used by both Travis for private repositories and Travis for open source. It is maintained by @BanzaiMan and falls under Team Sapphire's domain.
