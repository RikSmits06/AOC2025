import day3/puzzle1
import gleam/int
import gleam/list

pub fn puzzle_2() -> Int {
  let banks = puzzle1.read_banks_from_file("input/input3_1.txt")
  banks
  |> list.map(fn(x) { puzzle1.max_joltage(x, 12) })
  |> int.sum()
}
