with import <nixpkgs> {};

let
  pythonPackages = python39Packages;
in
  stdenv.mkDerivation {
    name = "impurePythonEnv";
    src=null;

    buildInputs = [
      #These are required for virt env and pip to work
      pythonPackages.virtualenv
      pythonPackages.pip

      #Any pip dependencies below:
      pythonPackages.tkinter

    ];

    shellHook = ''
      SOURCE_DATE_EPOCH=$(date +%s)
      virtualenv --python=${pythonPackages.python.interpreter} --no-setuptools venv
      export PATH=$PWD/venv/bin:PATH
      pip install -r requirements.txt
    '';
  }
