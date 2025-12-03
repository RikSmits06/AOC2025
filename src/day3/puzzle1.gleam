import gleam/float
import gleam/int
import gleam/list
import gleam/string
import util

pub type Bank {
  Bank(joltages: List(Int))
}

pub fn puzzle_1() -> Int {
  let banks = read_banks_from_file("input/input3_1.txt")
  banks
  |> list.map(fn(b) { max_joltage(b, 2) })
  |> int.sum()
}

pub fn max_joltage(bank: Bank, n_batteries: Int) -> Int {
  case bank {
    _ if n_batteries == 0 -> 0
    Bank([]) -> 0
    Bank([number]) -> number
    Bank(numbers) -> {
      let slice = list.take(numbers, list.length(numbers) - n_batteries + 1)
      let assert Ok(first) = list.max(slice, int.compare)
      let remaining =
        list.drop_while(numbers, fn(x) { x < first }) |> list.drop(1)
      let assert Ok(mult) = int.power(10, int.to_float(n_batteries - 1))
      first * float.round(mult) + max_joltage(Bank(remaining), n_batteries - 1)
    }
  }
}

pub fn read_banks_from_file(filename: String) -> List(Bank) {
  let lines = util.read_lines(filename)
  list.map(lines, line_to_bank)
}

fn line_to_bank(line: String) -> Bank {
  let chars = string.to_graphemes(line)
  let numbers =
    list.map(chars, fn(x) {
      let assert Ok(n) = int.parse(x)
      n
    })
  Bank(numbers)
}
