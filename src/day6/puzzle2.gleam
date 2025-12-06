import day6/puzzle1
import gleam/list
import gleam/string
import simplifile
import util

pub fn puzzle_2() -> Int {
  read_file("input/input6_1.txt")
  |> list.fold(0, fn(state, col) { state + puzzle1.calculate_column(col) })
}

fn read_file(filename: String) {
  let assert Ok(lines) = simplifile.read(filename)
  let lines =
    lines
    |> string.split("\r\n")
    |> list.map(string.to_graphemes)
    |> list.transpose()

  lines
  |> list.map(fn(x) { list.map(x, string.trim) })
  |> list.chunk(is_totally_empty)
  |> list.filter(fn(x) {
    let assert Ok(x) = list.first(x)
    !is_totally_empty(x)
  })
  |> list.map(chunk_to_row)
  |> list.map(fn(x) {
    let #(x, y) = x
    puzzle1.HomeworkColumn(y, x)
  })
}

fn chunk_to_row(chunk: List(List(String))) -> #(String, List(Int)) {
  let assert Ok(first) = list.first(chunk)
  let assert Ok(operator) = list.last(first)
  let chunk =
    list.map(chunk, fn(x) {
      list.reverse(x) |> list.drop(1) |> list.reverse() |> string.join("")
    })
    |> util.strings_to_ints()
  #(operator, chunk)
}

fn is_totally_empty(s: List(String)) -> Bool {
  list.all(s, string.is_empty)
}
