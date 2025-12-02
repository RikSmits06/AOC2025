import gleam/int
import gleam/list
import gleam/string
import util

pub type Range {
  IdRange(start: Int, end: Int)
}

pub fn puzzle_1() -> Int {
  let ranges = file_to_ranges("input/input2_1.txt")
  list.map(ranges, find_invalid_in_range)
  |> list.flatten()
  |> list.fold(0, int.add)
}

pub fn find_invalid_in_range(range: Range) -> List(Int) {
  let numbers = list.range(range.start, range.end)
  use number <- list.filter(numbers)
  number
  |> int.to_string()
  |> repeating_pattern()
}

pub fn repeating_pattern(s: String) -> Bool {
  let size = string.length(s)
  let mid_point = size / 2
  let left = string.slice(s, 0, mid_point)
  let right = string.slice(s, mid_point, size)
  left == right
}

pub fn file_to_ranges(filename: String) -> List(Range) {
  let lines = util.read_lines(filename)
  let lines = list.map(lines, line_to_ranges)
  list.flatten(lines)
}

fn line_to_ranges(line: String) -> List(Range) {
  let split_ranges = string.split(line, on: ",")
  use range <- list.map(split_ranges)
  let assert [start, end] = string.split(range, on: "-")
  let assert Ok(start) = int.parse(start)
  let assert Ok(end) = int.parse(end)
  IdRange(start, end)
}
