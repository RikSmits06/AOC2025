import day2/puzzle1
import gleam/int
import gleam/list
import gleam/string
import parallel_map

pub fn puzzle_2() -> Int {
  puzzle1.file_to_ranges("input/input2_1.txt")
  |> parallel_map.list_pmap(
    any_invalid_in_range,
    parallel_map.MatchSchedulersOnline,
    3000,
  )
  |> list.map(fn(x) {
    let assert Ok(x) = x
    x
  })
  |> list.flatten()
  |> int.sum()
}

pub fn any_repeating_pattern(s: String) -> Bool {
  let size = string.length(s)
  let mid_point = size / 2
  let sub_patterns = list.range(mid_point, 0)
  use _, sub_pattern <- list.fold_until(sub_patterns, False)
  case sub_pattern {
    _ if size % sub_pattern == 0 -> {
      let pattern =
        string.slice(s, 0, sub_pattern) |> string.repeat(size / sub_pattern)
      case pattern == s {
        True -> list.Stop(True)
        False -> list.Continue(False)
      }
    }
    _ -> list.Continue(False)
  }
}

pub fn any_invalid_in_range(range: puzzle1.Range) -> List(Int) {
  let numbers = list.range(range.start, range.end)
  use number <- list.filter(numbers)
  number
  |> int.to_string()
  |> any_repeating_pattern()
}
