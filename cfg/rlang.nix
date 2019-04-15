{ config, lib, pkgs, ... }:
with pkgs;
let
  RStudio-with-my-packages = rstudioWrapper.override{
    packages = with rPackages; [
      anytime
      checkmate
      devtools
      httr
      jsonlite
      knitr
      mockery
      Rcpp
      rmarkdown
      roxygen2
      testthat
      tidyverse
      xts
    ];
  };
in
{
  environment.systemPackages = with pkgs; [
    RStudio-with-my-packages
    pandoc
  ];
}
