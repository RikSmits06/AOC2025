import gleam/int
import gleam/list
import gleam/string
import util

pub fn puzzle_1() -> Int {
  file_to_homework("input/input6_1.txt")
  |> list.fold(0, fn(state, col) { state + calculate_column(col) })
}

pub fn calculate_column(col: HomeworkColumn) -> Int {
  case col.operator {
    "*" -> int.product(col.args)
    "+" -> int.sum(col.args)
    _ -> 0
  }
}

pub type HomeworkColumn {
  HomeworkColumn(args: List(Int), operator: String)
}

pub fn file_to_homework(filename: String) -> List(HomeworkColumn) {
  let lines = util.read_lines(filename)
  let n_lines = list.length(lines)
  let numbers =
    list.take(lines, n_lines - 1)
    |> list.map(fn(x) {
      string.split(x, on: " ") |> list.filter(fn(x) { !string.is_empty(x) })
    })
    |> list.map(util.strings_to_ints)
    |> list.transpose()
  let assert Ok(operators) = list.last(lines)
  let operators =
    string.split(operators, on: " ")
    |> list.filter(fn(x) { !string.is_empty(x) })

  list.map2(numbers, operators, fn(n, o) { HomeworkColumn(n, o) })
}
