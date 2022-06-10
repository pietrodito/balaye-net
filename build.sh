#!/bin/sh


emacs -Q --script ./build-site.el

rm -f public/*~
