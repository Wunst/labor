{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.python3.withPackages (ps: with ps; [
      jupyter
      ipython
      pandas
      numpy
      scipy
      sympy
      matplotlib
    ]))
  ];
}
