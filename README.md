# install-packages

Installs packages specified with the `packages` option. It leverages caching to increase build time.

## Example

Installs the two packages `git`, `subversion` and `apache`. Packages should be seperated by whitespace.

    - install-packages:
        packages: git subversion apache

You can also specify version.

    - install-packages:
        packages: apache2=2.2.20-1ubuntu1
