#!/bin/bash

set -e -u -o pipefail
source_libname=$1; shift
debug_libname=$1; shift
rewriting=("$@"); shift

q='"'
lib=../src
tmp="$(mktemp --tmpdir incremental_debugXXXXXX)"
(
  for module in $(cat $lib/$source_libname.pack-order); do
    if [ -f $lib/$module.ml ] && [ -f $lib/$module.mli ]; then
      echo module ${module^} : sig
      echo '#1' $q$module.mli$q
      cat $lib/$module.mli
      echo end = struct
      echo '#1' $q$module.ml$q
      cat $lib/$module.ml
      echo end
    elif [ -f $lib/$module.ml ]; then
      echo module ${module^} = struct
      echo '#1' $q$module.ml$q
      cat $lib/$module.ml
      echo end
    elif [ -f $lib/$module.mli ]; then
      echo module rec ${module^} : sig
      echo '#1' $q$module.mli$q
      cat $lib/$module.mli
      echo end = ${module^}
    fi
    echo
  done
  echo 'let () = assert Import.debug'
) | "${rewriting[@]}" > "$tmp"
mv "$tmp" $debug_libname.ml
chmod -w $debug_libname.ml
