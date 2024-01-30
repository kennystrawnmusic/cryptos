{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {
  buildInputs = with pkgs; [
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
    cp ${pkgs.OVMFFull.fd}/FV/OVMF.fd OVMF-pure-efi.fd
    '';
  
  # Needed for testing
  RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
    pkgs.OVMFFull
    pkgs.qemu
  ]);
  # Add libvmi, glibc, clang, glib headers to bindgen search path
  BINDGEN_EXTRA_CLANG_ARGS = 
  # Includes with normal include path
  (builtins.map (a: ''-I"${a}/include"'') [
    pkgs.OVMFFull
    pkgs.qemu
    pkgs.glibc.dev
  ])
  # Includes with special directory paths
  ++ [
    ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
    ''-I"${pkgs.glib.dev}/include/glib-2.0"''
    ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
  ];
}