import day3/puzzle1
import day3/puzzle2
import gleam/int
import gleam/list
import gleam/string

pub fn puzzle_1_test() {
  assert puzzle1.puzzle_1() == 17_107
}

pub fn puzzle_2_test() {
  assert puzzle2.puzzle_2() == 169_349_762_274_117
}

pub fn max_bank_joltage_test() {
  assert puzzle1.max_joltage(
      puzzle1.Bank(string_to_int_list("987654321111111")),
      2,
    )
    == 98
  assert puzzle1.max_joltage(
      puzzle1.Bank(string_to_int_list("811111111111119")),
      2,
    )
    == 89
  assert puzzle1.max_joltage(
      puzzle1.Bank(string_to_int_list("234234234234278")),
      2,
    )
    == 78
  assert puzzle1.max_joltage(
      puzzle1.Bank(string_to_int_list("818181911112111")),
      2,
    )
    == 92
}

fn string_to_int_list(s: String) -> List(Int) {
  let chars = string.to_graphemes(s)
  use char <- list.map(chars)
  let assert Ok(n) = int.parse(char)
  n
}
