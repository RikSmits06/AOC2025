import gleam/int
import gleam/list
import gleam/order

/// Represents a range. The min and max are inclusive.
pub type Range {
  Range(min: Int, max: Int)
}

/// Simplifies the ranges. If for instance we have the ranges (3, 5) and (6, 10) it can be simplified to (3, 10).
/// Will also sort the output.
pub fn simplify_ranges(ranges: List(Range)) {
  ranges
  |> sort_ranges()
  |> reduce_ranges()
}

/// Compares 2 ranges, the one with the shortest min will be in.
pub fn compare_range(x: Range, y: Range) -> order.Order {
  int.compare(x.min, y.min)
}

pub fn range_size(range: Range) -> Int {
  range.max - range.min + 1
}

pub fn sort_ranges(ranges: List(Range)) -> List(Range) {
  list.sort(ranges, compare_range)
}

/// Checks if x is in the range.
pub fn in_range(x: Int, range: Range) -> Bool {
  range.min <= x && x <= range.max
}

fn reduce_ranges(ranges: List(Range)) -> List(Range) {
  case ranges {
    [] -> []
    [x] -> [x]
    [x, y, ..remaining] if x.max >= y.max -> reduce_ranges([x, ..remaining])
    [x, y, ..remaining] if y.min - 1 <= x.max ->
      reduce_ranges([Range(x.min, y.max), ..remaining])
    [x, y, ..remaining] -> [x, ..reduce_ranges([y, ..remaining])]
  }
}
