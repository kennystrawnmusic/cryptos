{
  pkgs ? import <nixpkgs> rec {
    system = if (import <nixpkgs>{}).hostPlatform.isDarwin then "x86_64-darwin" else null;
  }
}:

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    (OVMF.overrideAttrs (attrs: rec {
      preBuild = ''
      find $TMPDIR -iname "*.makefile" -exec sed -i 's/-Werror//g' {} \;
      find $TMPDIR -iname "*.template" -exec sed -i 's/-Werror//g' {} \;
      '';
    }))
    clang
    llvmPackages.bintools
    rustup
  ];
  RUSTC_VERSION = pkgs.lib.readFile ./rust-toolchain.toml;
  # https://github.com/rust-lang/rust-bindgen#environment-variables
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  HISTFILE = toString ./.history;
  shellHook = ''
    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
    if [ ! -f OVMF-pure-efi.fd ]; then
      cp ${pkgs.OVMF.fd}/FV/OVMF.fd OVMF-pure-efi.fd
    fi
    '';
  
  # Needed for testing
  RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
    pkgs.qemu
  ]);

  # Force OVMF to compile properly on macOS
  env.NIX_CFLAGS_COMPILE = "-Wno-unneeded-internal-declaration";
  env.NIX_CXXFLAGS_COMPILE = "-Wno-unneeded-internal-declaration";

  # Add the test packages to the bindgen search path
  BINDGEN_EXTRA_CLANG_ARGS = 
  # Includes with normal include path
  (if (import <nixpkgs>{}).hostPlatform.isLinux then builtins.map (a: ''-I"${a}/include"'') [
    pkgs.glibc.dev
  ] else [])
  # Includes with special directory paths
  ++ [
    ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
    ''-I"${pkgs.glib.dev}/include/glib-2.0"''
    ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
  ];
}