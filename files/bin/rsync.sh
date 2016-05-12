#!/bin/sh
rsync -azv -e ssh /backup/ $SERVERPATH
