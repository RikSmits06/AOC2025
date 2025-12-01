import gleam/int
import gleam/list
import gleam/result
import util

pub fn puzzle_1() -> Int {
  let rotations = file_to_rotations("input/input1_1.txt")
  count_zeros(rotations, 50)
}

fn count_zeros(rotations: List(Rotation), starting_point: Int) -> Int {
  count_zeros_acc(rotations, starting_point, 0)
}

fn count_zeros_acc(
  rotations: List(Rotation),
  starting_point: Int,
  acc: Int,
) -> Int {
  let acc = case starting_point {
    0 -> acc + 1
    _ -> acc
  }

  case rotations {
    [] -> acc
    [rotation, ..remaining] ->
      count_zeros_acc(remaining, apply_rotation(starting_point, rotation), acc)
  }
}

pub fn apply_rotation(state: Int, rotation: Rotation) -> Int {
  case rotation {
    Left(x) -> fit_number(state - x)
    Right(x) -> fit_number(state + x)
  }
}

pub fn fit_number(number: Int) -> Int {
  case number {
    n if n > 99 -> fit_number(n - 100)
    n if n < 0 -> fit_number(n + 100)
    n -> n
  }
}

pub type Rotation {
  Left(Int)
  Right(Int)
}

fn line_to_rotation(line: String) -> Rotation {
  case line {
    "R" <> n -> Right(int.parse(n) |> result.unwrap(0))
    "L" <> n -> Left(int.parse(n) |> result.unwrap(0))
    _ -> panic as "Unknown rotation char."
  }
}

pub fn file_to_rotations(file_name: String) -> List(Rotation) {
  util.read_lines(file_name) |> list.map(line_to_rotation)
}
