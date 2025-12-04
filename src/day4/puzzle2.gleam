import day4/puzzle1
import gleam/list
import parallel_map
import util

pub fn puzzle_2() -> Int {
  let map = puzzle1.read_map_from_file("input/input4_1.txt")
  let paper_rolls_start = puzzle1.number_of_paper_rolls(map)
  let reduced_map = reduce_map(map, paper_rolls_start)
  let paper_rolls_end = puzzle1.number_of_paper_rolls(reduced_map)
  paper_rolls_start - paper_rolls_end
}

fn reduce_map(map: puzzle1.Map, n_paper_rolls: Int) -> puzzle1.Map {
  let puzzle1.Map(tiles) = map
  let tiles =
    tiles
    |> util.parallel_filter(parallel_map.WorkerAmount(15), 1000, fn(x) {
      !{
        x.paper_roll && puzzle1.get_true_neighbours(x, map) |> list.length() < 4
      }
    })

  let new_map = puzzle1.Map(tiles)
  let new_map_n_rolls = puzzle1.number_of_paper_rolls(new_map)

  case new_map_n_rolls == n_paper_rolls {
    True -> new_map
    False -> reduce_map(new_map, new_map_n_rolls)
  }
}
