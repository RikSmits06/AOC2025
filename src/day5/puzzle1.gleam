import gleam/int
import gleam/list
import gleam/string
import range
import util

pub fn puzzle_1() -> Int {
  let inventory = read_inventory_from_file("input/input5_1.txt")
  list.count(inventory.products, fn(p) { in_any_range(p, inventory.fresh) })
}

fn in_any_range(x: Int, ranges: List(range.Range)) -> Bool {
  list.any(ranges, fn(r) { range.in_range(x, r) })
}

pub type Inventory {
  Inventory(fresh: List(range.Range), products: List(Int))
}

pub fn read_inventory_from_file(filename: String) -> Inventory {
  let lines = util.read_lines(filename)
  let fresh =
    list.take_while(lines, fn(x) { !string.is_empty(x) })
    |> list.map(line_to_range)
  let products =
    list.drop_while(lines, fn(x) { !string.is_empty(x) })
    |> list.drop(1)
    |> list.map(fn(x) {
      let assert Ok(x) = int.parse(x)
      x
    })
  Inventory(fresh, products)
}

fn line_to_range(line: String) -> range.Range {
  let assert Ok(#(x, y)) = string.split_once(line, on: "-")
  let assert Ok(x) = int.parse(x)
  let assert Ok(y) = int.parse(y)
  range.Range(x, y)
}
