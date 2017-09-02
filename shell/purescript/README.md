# Nixpkgs + PureScript example

## Strategy

Use Nixpkgs to get the PureScript [compiler](https://github.com/purescript/purescript) (`purs`) and [psc-package](https://github.com/purescript/psc-package). Use package sets to list our dependencies.

This lets us avoid messing with _npm_, _Bower_, _Grunt_, _Gulp_ and _Pulp_ entirely.

## Use

### REPL

```
$ nix-shell
$ ./repl
> import Main (hello)
> hello
"Hello world."
```

Note that even though `Main.hello` will autocomplete as soon as the REPL starts, the command won't work until you actually import `Main`.

# Package set notes

_psc-package_ has no equivalent to _Stack_'s `extra-deps`. If you need a package that's not in an official package set you have to make your own. To do so:

+ Clone [the offical package sets repo](https://github.com/purescript/package-sets)
+ Add the new package (instructions [here](https://github.com/purescript/psc-package#add-a-package-to-the-package-set))
+ Commit your changes
+ Tag your commit
+ Update `./psc-package.json` in this repo. Change `"set"` to your tag and `"source"` to the location you cloned _purescript-package-sets_ to, e.g. `"../purescript-package-sets"`
