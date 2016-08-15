# CA$H€R

## Purpose

Casher is a Ruby script used by [Travis Build](https://github.com/travis-ci/travis-build) to fetch, create, and update caches. 

Casher checks the URLs provided to it for existing caches at the location and stops when it finds one. It will `fetch` the cache and expand it at the root of the OS. 

If a cache is not found at any of the URLs, Casher creates one. Casher will `add` the directories specified to be cached and then `push` the cache to a URL.

Casher checks for changes in existing caches using `md5deep`, which can recursively compute the MD5 checksum for every file in a directory. If a difference in the MD5 checksums are found, casher will pack a new archive and `push` it to a URL.


## Interaction With The System

[Travis Build](https://github.com/travis-ci/travis-build) generates a list of URLs for caches and provides them to Casher. If caching shortcuts are used in a user's Travis configuration, Travis Build converts them to directory information as Casher is only concerned about which directories to archive.

Travis Build can also run `before_cache`, if it is specified in a user's .travis.yml, to remove files that could change the checksums and cause Casher to invalidate the cache.

## Status

Casher is actively used by both Travis for private repositories and Travis for open source. It is maintained by @BanzaiMan and falls under Team Sapphire's domain.

## License & copyright information

See LICENSE file.

Copyright (c) 2011-2016 [Travis CI development
team](https://github.com/travis-ci).

![Comic about cash](http://4.bp.blogspot.com/_XdP6Lp2ceqY/TEJuww2sk2I/AAAAAAAAWpY/EmWweRXahGM/s1600/tumblr_l55qcmER041qznd83o1_500.jpg)
