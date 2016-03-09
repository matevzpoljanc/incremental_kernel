open Core_kernel.Std

module Import : sig
  val debug : bool
  val verbose : bool
  val sexp_of_time_ns : (Time_ns.t -> Sexp.t) ref
  val sexp_of_time_ns_span : (Time_ns.Span.t -> Sexp.t) ref
end

module Config : module type of Incremental_kernel.Config

module Incremental_intf : sig
  module type S_abstract_times = Incremental_kernel.Incremental_intf.S_abstract_times
end

module Std : sig
  module Incremental : module type of Incremental_kernel.Incremental
end
