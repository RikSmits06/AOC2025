import day2/puzzle1
import gleam/int
import gleam/list
import gleam/string

pub fn puzzle_2() -> Int {
  let ranges = puzzle1.file_to_ranges("input/input2_1.txt")
  list.map(ranges, any_invalid_in_range)
  |> list.flatten()
  |> int.sum()
}

pub fn any_repeating_pattern(s: String) -> Bool {
  let size = string.length(s)
  let mid_point = size / 2
  let sub_patterns = list.range(0, mid_point)
  let patterns = list.map(sub_patterns, fn(x) { string.slice(s, 0, x) })
  let matches =
    list.map(patterns, fn(x) { string.replace(s, each: x, with: "") == "" })
  list.any(matches, fn(x) { x })
}

pub fn any_invalid_in_range(range: puzzle1.Range) -> List(Int) {
  let numbers = list.range(range.start, range.end)
  use number <- list.filter(numbers)
  number
  |> int.to_string()
  |> any_repeating_pattern()
}
