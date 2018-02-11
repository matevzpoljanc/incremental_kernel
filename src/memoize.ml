open Core_kernel

let table1 = Hashtbl.Poly.create ()
let table2 = Hashtbl.Poly.create ()
let table3 = Hashtbl.Poly.create ()
let table4 = Hashtbl.Poly.create ()
let counter = ref 0
let new_function_id () = 
  let count= !counter in 
      counter := count + 1; count
let memoize f =
  let f_id = new_function_id () in
  let g x =
    match Hashtbl.find table1 (f_id, x) with
    | Some z -> z
    | None -> let z = (f x) in
      Hashtbl.set table1 ~key:(f_id,x) ~data:z; z
      in
      g
  ;;

let memoize2 f =
  let f_id = new_function_id () in
  let g x y =
    match Hashtbl.find table2 (f_id,x,y) with
    | Some z -> z
    | None -> let z = (f x y) in
      Hashtbl.set table2 ~key:(f_id,x,y) ~data:z; z
      in
      g
  ;;

let memoize3 f =
  let f_id = new_function_id () in
  let g x0 x1 x2 =
    match Hashtbl.find table3 (f_id,x0,x1,x2) with
    | Some z -> z
    | None -> let z = (f x0 x1 x2) in
      Hashtbl.set table3 ~key:(f_id,x0,x1,x2) ~data:z; z
      in
      g
  ;;

let memoize4 f =
  let f_id = new_function_id () in
  let g x0 x1 x2 x3 =
    match Hashtbl.find table4 (f_id,x0,x1,x2,x3) with
    | Some z -> z
    | None -> let z = (f x0 x1 x2 x3) in
      Hashtbl.set table4 ~key:(f_id,x0,x1,x2,x3) ~data:z; z
      in
      g
  ;;