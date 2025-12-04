import parallel_map
import util

pub fn filter_test() {
  assert util.parallel_filter(
      [1, 2, 3, 4, 5],
      parallel_map.WorkerAmount(2),
      1000,
      fn(x) { x > 3 },
    )
    == [4, 5]
}
