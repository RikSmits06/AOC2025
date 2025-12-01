import day1/puzzle1.{
  type Rotation, Left, Right, apply_rotation, file_to_rotations,
}
import gleam/int

pub fn puzzle_2() -> Int {
  let rotations = file_to_rotations("input/input1_1.txt")
  count_all_zeros(rotations, 50)
}

fn count_all_zeros(rotations: List(Rotation), state: Int) -> Int {
  case rotations {
    [rotation, ..remaining] -> {
      let count = count_passes_zero(state, rotation)
      let new_state = apply_rotation(state, rotation)
      count + count_all_zeros(remaining, new_state)
    }
    [] -> 0
  }
}

fn count_passes_zero(state: Int, rotation: Rotation) -> Int {
  case rotation {
    Left(x) if state - x <= 0 ->
      { int.absolute_value(state - x) } / 100 + 1 * bool_to_int(state != 0)
    Right(x) if state + x >= 100 -> { state + x } / 100
    _ -> 0
  }
}

fn bool_to_int(b: Bool) -> Int {
  case b {
    True -> 1
    False -> 0
  }
}
