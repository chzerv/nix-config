# Import our custom packages
{inputs, ...}: (final: prev: import ../pkgs {pkgs = final;})
