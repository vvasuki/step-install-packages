# install-packages

Installs packages specified with the `packages` option. It leverages caching to decrease build time.

## Options

* `packages`: Option is required. The name of the packages to install.

## Example

Installs the three packages `git`, `subversion` and `apache`. Packages should be seperated by whitespace.

    - install-packages:
        packages: git subversion apache

You can also specify version.

    - install-packages:
        packages: apache2=2.2.20-1ubuntu1
