#use "topfind";;
#require "js-build-tools.oasis2opam_install";;

open Oasis2opam_install;;

generate ~package:"incremental_kernel"
  [ oasis_lib "incremental_kernel"
  ; file "META" ~section:"lib"
  ]
