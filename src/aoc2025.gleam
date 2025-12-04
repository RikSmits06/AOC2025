import day4/puzzle1
import gleam/io
import gleam/time/duration
import gleam/time/timestamp

pub fn main() -> Nil {
  let start_time = timestamp.system_time()

  echo puzzle1.puzzle_1()

  let end_time = timestamp.system_time()
  let duration = timestamp.difference(start_time, end_time)
  duration.to_iso8601_string(duration) |> io.println()
  Nil
}
