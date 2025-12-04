import day2/puzzle1
import day2/puzzle2
import gleam/int
import gleam/list

pub fn repeating_pattern_test() {
  assert puzzle1.repeating_pattern("11")
  assert puzzle1.repeating_pattern("22")
  assert !puzzle1.repeating_pattern("222")
  assert puzzle1.repeating_pattern("1010")
  assert puzzle1.repeating_pattern("1188511885")
  assert !puzzle1.repeating_pattern("113")
  assert !puzzle1.repeating_pattern("3113")
  assert !puzzle1.repeating_pattern("1112")
  assert !puzzle1.repeating_pattern("132321")
  assert !puzzle1.repeating_pattern("131")
}

pub fn find_invalid_in_range_test() {
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(11, 22)) == [11, 22]
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(95, 115)) == [99]
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(998, 1012)) == [1010]
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(
      1_188_511_880,
      1_188_511_890,
    ))
    == [1_188_511_885]
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(222_220, 222_224))
    == [222_222]

  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(1_698_522, 1_698_528))
    == []
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(446_443, 446_449))
    == [446_446]
  assert puzzle1.find_invalid_in_range(puzzle1.IdRange(38_593_856, 38_593_862))
    == [38_593_859]
}

pub fn any_repeating_pattern_test() {
  let invalids = [
    11,
    22,
    99,
    111,
    999,
    1010,
    1_188_511_885,
    222_222,
    446_446,
    38_593_859,
    565_656,
    824_824_824,
    2_121_212_121,
  ]

  use invalid <- list.map(invalids)
  assert puzzle2.any_repeating_pattern(int.to_string(invalid))
}
