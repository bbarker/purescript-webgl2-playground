# purescript-webgl2-playground

This is not a library, it is a playground for trying out WebGL2 tutorials and
ideas in PureScript. Hopefully you can also use this project as a template
for your own WebGl2 project in PureScript.

## Notable libraries used

- [purescript-webgl2-raw](https://pursuit.purescript.org/packages/purescript-webgl2-raw)
- [purescript-concur](https://github.com/ajnsit/purescript-concur) - Awesome
  wrapper around React (or other vDOM-esque libs); using this mainly to create
  multiple canvas elements, or elements outside the canvas (loading different
  demos). You may not want to use this if you are extremely concerned with JS
  file size, but it isn't bad - maybe an extra 70KB gzipped.

## Tutorials used

- [WebGL2 Fundamentals](https://webgl2fundamentals.org/)

# Caveats and Notes

As this is primarily designed for personal use, documentation may be lacking
in some cases - feel free to file in issue or PR; feel free to also open
an issue or PR if you see something that can be improved.

# Buidling

## Demos

- `cd app && npm run prod`

## Tests

- `cd test && npm run testbrowser`

## Docker

* Run `./psc.sh <command>`, e.g. `./psc.sh pulp --psc-package build`. This will run
the command in the container with the CWD mounted and then exit. Alternatively
if you want to issue multiple commands in the container quickly, you can
run `./psc.sh bash`.

