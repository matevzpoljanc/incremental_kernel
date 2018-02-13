let (>>=) = Lwt.bind

module MemoResult(K:Tc.S0)(V:Tc.S0) = struct
    module AO = Irmin_mem.AO(Irmin.Hash.SHA1)(V)
    exception VauleNotFoundInRW
    exception ValueNotFoundInAO
    module Key = struct
        include K
        let to_hum t = match Ezjsonm.decode_string (to_json t) with
            | Some s -> s
            | None -> raise (Ezjsonm.Parse_error ((to_json t), "Invalid arguments" ))
        let of_hum s = of_json (Ezjsonm.from_string s)
    end

    module RW = Irmin_mem.RW(Key)(Irmin.Hash.SHA1)

    type t = {table_rw: RW.t; table_ao: AO.t}
    let create () =
        let config = Irmin_git.config () in
        AO.create config >>= fun ao_t ->
        RW.create config >>= fun rw_t ->
        Lwt.return {table_rw = rw_t; table_ao = ao_t}

    let find t key = RW.read t.table_rw key >>= 
        function None -> raise VauleNotFoundInRW
            |(Some ao_key) -> AO.read t.table_ao ao_key >>= 
                function None -> raise ValueNotFoundInAO
                    | Some v -> Lwt.return v
    let insert t key value = AO.add t.table_ao value >>= fun k ->
        RW.update t.table_rw key k
    
    let find_or_add t key ~default = RW.read t.table_rw key >>=
        function None -> insert t key (default ()) >>= fun () -> find t key
        | Some _ -> find t key
end

