import day2/puzzle2
import gleam/io
import gleam/time/duration
import gleam/time/timestamp

pub fn main() -> Nil {
  let start_time = timestamp.system_time()

  echo puzzle2.puzzle_2()

  let end_time = timestamp.system_time()
  let duration = timestamp.difference(start_time, end_time)
  duration.to_iso8601_string(duration) |> io.println()
  Nil
}
