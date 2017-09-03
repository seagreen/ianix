# Nixpkgs + PureScript example

## Strategy

The "hybrid approach".

_Nixpkgs_ provides system dependencies like the PureScript [compiler](https://github.com/purescript/purescript) (`purs`) and [psc-package](https://github.com/purescript/psc-package).

_psc-package_ provides language-specific dependencies.

This lets us avoid messing with _npm_, _Bower_, _Grunt_, _Gulp_ and _Pulp_ entirely.

The hybrid approach isn't as efficient as using _Nix_ for everything (e.g. with regards to caching), but lets us keep compatibility with the part of the ecosystem using _psc-package_.

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

### Webapp

```
$ nix-shell
$ ./build
$ firefox src/index.html
```

## Issues

You'll regularly see this error (for instance after running `./build`):

```
psc-package: failed to create OS thread: Cannot allocate memory
```

Try repeating the command a few times, it will eventually succeed.

I haven't reported this issue upstream yet, if someone else does before me let me know.

# Package set notes

_psc-package_ has no equivalent to _Stack_'s `extra-deps`. If you need a package that's not in an official package set you have to make your own. To do so:

+ Clone [the offical package sets repo](https://github.com/purescript/package-sets)
+ Add the new package (instructions [here](https://github.com/purescript/psc-package#add-a-package-to-the-package-set))
+ Commit your changes
+ Tag your commit
+ Update `./psc-package.json` in this repo. Change `"set"` to your tag and `"source"` to the location you cloned _purescript-package-sets_ to, e.g. `"../purescript-package-sets"`
