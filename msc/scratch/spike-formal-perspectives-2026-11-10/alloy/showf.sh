#!/bin/sh
# usage: ./showf.sh <solution.txt> -- a fork instance, with the bookkeeping relations dropped
./show.sh "$1" | grep -v "^Time=\|^Piece=\|^Asm=\|^LineEvent=\|^BaseEvent=\|^Event=\|^Crit=\|^Valid\|^Whole\|^View=\|^Version=\|^Veritoid=\|^Claim=\|^Result=\|^Outline=\|^C=\|^A=\|^B=\|^M=\|^Write=\|^Evid=\|^Affirm=\|^MarkRoot=\|^OtherCrit=\|^Raise=\|^SetAside=\|^Same="
