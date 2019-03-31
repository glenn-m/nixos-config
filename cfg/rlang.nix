{ config, lib, pkgs, ... }:
with pkgs;
let
  RStudio-with-my-packages = rstudioWrapper.override{
    packages = with rPackages; [
      anytime
      checkmate
      dplyr
      ggplot2
      httr
      jsonlite
      knitr
      Rcpp
      rmarkdown
      roxygen2
      testthat
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
