let request =
  if Array.length Sys.argv > 1 then Sys.argv.(1) else "{\"op\":\"version\"}"

let () = print_endline (Forma_ocaml.Abi.handle_json request)
