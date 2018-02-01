open Core_kernel

let memoize f =
  let table = Hashtbl.Poly.create () in
  let g x =
    match Hashtbl.find table x with
    | Some z -> z
    | None -> let z = (f x) in
      Hashtbl.set table ~key:x ~data:z; z
      in
      g
  ;;

let memoize2 f =
  let table = Hashtbl.Poly.create () in
  let g x y =
    match Hashtbl.find table (x,y) with
    | Some z -> z
    | None -> let z = (f x y) in
      Hashtbl.set table ~key:(x,y) ~data:z; z
      in
      g
  ;;

let memoize3 f =
  let table = Hashtbl.Poly.create () in
  let g x0 x1 x2 =
    match Hashtbl.find table (x0,x1,x2) with
    | Some z -> z
    | None -> let z = (f x0 x1 x2) in
      Hashtbl.set table ~key:(x0,x1,x2) ~data:z; z
      in
      g
  ;;

let memoize4 f =
  let table = Hashtbl.Poly.create () in
  let g x0 x1 x2 x3 =
    match Hashtbl.find table (x0,x1,x2,x3) with
    | Some z -> z
    | None -> let z = (f x0 x1 x2 x3) in
      Hashtbl.set table ~key:(x0,x1,x2,x3) ~data:z; z
      in
      g
  ;;