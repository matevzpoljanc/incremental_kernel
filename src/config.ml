open Core_kernel.Std
open Import

include Config_intf

module Default () = struct
  let bind_lhs_change_should_invalidate_rhs = true

  let start = Time_ns.now ()

  module Alarm_precision = Timing_wheel_ns.Alarm_precision

  let timing_wheel_config =
    let alarm_precision = Time_ns.Span.millisecond in
    let bits =
      Float.iround_up_exn
        ( log (Time_ns.Span.( // ) (Time_ns.Span.of_day 30.) alarm_precision)
          /. log 2. )
    in
    let level_bits = [ 14; 13; 5 ] in
    assert (bits = List.fold level_bits ~init:0 ~f:(+));
    Timing_wheel_ns.Config.create
      ~alarm_precision:(Timing_wheel_ns.Alarm_precision.of_span alarm_precision)
      ~level_bits:(Timing_wheel_ns.Level_bits.create_exn level_bits)
      ()
  ;;
end
