#!/usr/bin/env bash

hmk() {
  local CMD=$1
  case "$CMD" in
    init)
      init
      ;;
    make)
      make
      ;;
    clean)
      clean
      ;;
    *)
      helpHmk
      ;;
  esac
}

helpHmk() {
  echo "invalid hmk command $CMD, must be 'init', 'make', or 'clean'"
  exit 1
}

init() {
  local TEMPLATE_PATH=~/projects/hmk/template.rnw
  mkdir -p ./src
  cp "$TEMPLATE_PATH" "./src/homework.rnw"
}

make() {
  cd ./src/
  R CMD Sweave ./homework.Rnw
  pdflatex ./homework.tex
  cd ../
  mv ./src/homework.pdf ./homework.pdf
  open ./homework.pdf
}

clean() {
  rm homework.pdf ./src/homework.aux ./src/homework.log ./src/homework.tex
}

hmk $@