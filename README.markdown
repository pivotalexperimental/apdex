Overview
========
Calculate [Apdex](http://apdex.org) scores from an Apache or Nginx log.

Usage
=====

    apdex_from_log --help
    
    egrep '/users/.+/edit' access.log | apdex_from_log --threshold 0.5 --time-column 11


Example Output
==============

    Score: 0.81
    Satisfied: 63
    Tolerating: 37
    Frustrated: 0


Community
=========

Github: [http://github.com/pivotal/apdex](http://github.com/pivotal/apdex)

Tracker: [http://www.pivotaltracker.com/projects/14145](http://www.pivotaltracker.com/projects/14145)