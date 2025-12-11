module util

import os

pub fn input_path(day int, part string) string {
    day_str := 'day${day:02}'
    filename := '${day_str}_${part}.txt'
    return os.join_path('src', day_str, filename)
}

pub fn read_input_raw(day int, part string) !string {
    path := input_path(day, part)
    return os.read_file(path)!
}
