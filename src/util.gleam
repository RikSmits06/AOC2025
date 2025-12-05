import file_streams/file_stream
import gleam/list
import gleam/string
import parallel_map

/// Checks if number a is divisible by b.
pub fn divisible(a: Int, b: Int) -> Bool {
  a % b == 0
}

/// Checks if a is not divisible by b.
pub fn not_divisible(a: Int, b: Int) -> Bool {
  !divisible(a, b)
}

/// Reads the given file and then splits on line breaks.
pub fn read_lines(file_name: String) -> List(String) {
  let assert Ok(file) = file_stream.open_read(file_name)
  read_lines_recursively(file)
}

fn read_lines_recursively(file: file_stream.FileStream) -> List(String) {
  let line = file_stream.read_line(file)

  case line {
    Ok(line) -> list.append([string.trim(line)], read_lines_recursively(file))
    Error(_) -> []
  }
}

/// Same as filter but then using parallel_map.
pub fn parallel_filter(
  data: List(a),
  wa: parallel_map.WorkerAmount,
  timeout_ms: Int,
  func: fn(a) -> Bool,
) -> List(a) {
  data
  |> parallel_map.list_pmap(
    fn(x) {
      let yes = func(x)
      case yes {
        True -> Ok(x)
        False -> Error(Nil)
      }
    },
    wa,
    timeout_ms,
  )
  |> list.filter_map(fn(x) {
    let assert Ok(x) = x
    x
  })
}
