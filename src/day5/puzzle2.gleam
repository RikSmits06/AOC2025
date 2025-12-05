import day5/puzzle1
import gleam/list
import range

pub fn puzzle_2() -> Int {
  puzzle1.read_inventory_from_file("input/input5_1.txt").fresh
  |> range.simplify_ranges()
  |> list.fold(0, fn(state, range) { range.range_size(range) + state })
}
