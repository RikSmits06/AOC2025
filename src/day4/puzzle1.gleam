import gleam/int
import gleam/list
import gleam/string
import util

const paper_roll = "@"

pub type Coords {
  Coords(x: Int, y: Int, paper_roll: Bool)
}

pub type Map {
  Map(tiles: List(Coords))
}

pub fn puzzle_1() {
  let map = read_map_from_file("input/input4_1.txt")
  let Map(tiles) = map
  tiles
  |> list.filter(fn(x) {
    x.paper_roll && get_true_neighbours(x, map) |> list.length() < 4
  })
  |> list.length()
}

pub fn get_true_neighbours(coord: Coords, map: Map) -> List(Coords) {
  use tile: Coords <- list.filter(map.tiles)
  let diff_x = int.absolute_value(coord.x - tile.x)
  let diff_y = int.absolute_value(coord.y - tile.y)
  case tile {
    _ if diff_x == 0 && diff_y == 0 -> False
    _ if diff_x <= 1 && diff_y <= 1 && tile.paper_roll -> True
    _ -> False
  }
}

pub fn read_map_from_file(filename: String) -> Map {
  util.read_lines(filename)
  |> list.index_map(fn(x, i) { parse_line(i, x) })
  |> list.flatten()
  |> Map()
}

fn parse_line(y: Int, line: String) -> List(Coords) {
  use char, index <- list.index_map(string.to_graphemes(line))
  Coords(index, y, char == paper_roll)
}
