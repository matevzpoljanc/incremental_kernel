let new_function_id = Memoize.new_function_id

module IrminHashTbl = Memo_result.MemoResult

let (>>=) = Lwt.bind


let m = Lwt_main.run (IrminHashTbl.create ())

let memoize_irmin f =
  let f_id = new_function_id () in
  let g x =
    Lwt_main.run @@ IrminHashTbl.find_or_add m (f_id,x) ~default:(fun () -> (f x)) in
  g
  ;;
let double = memoize_irmin (fun x -> x*2);;

assert (double 1 = 2);
assert (double 4 = 8)