import file_streams/file_stream
import gleam/list
import gleam/string

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
