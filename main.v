module main

import time
import day01
import day02
import day03
import day04
import day05
import day06

type SolverFn = fn (string) !string

const day01_a_embed = $embed_file('day01/day01_A.txt')
const day02_a_embed = $embed_file('day02/day02_A.txt')
const day03_a_embed = $embed_file('day03/day03_A.txt')
const day04_a_embed = $embed_file('day04/day04_A.txt')
const day05_a_embed = $embed_file('day05/day05_A.txt')
const day06_a_embed = $embed_file('day06/day06_A.txt')


struct Solver {
	name     string
	func     SolverFn @[required]
	data     string
	solution ?string // something i check after 
}

fn main() {
	solvers := [
		Solver{
			name: 'Day 01 A'
			func: day01.solve_a
			data: day01_a_embed.to_string()
			solution: "1120"
		},
		Solver{
			name: 'Day 01 B'
			func: day01.solve_b
			data: day01_a_embed.to_string()
			solution: "6554"
		},
		Solver{
			name: 'Day 02 A'
			func: day02.solve_a
			data: day02_a_embed.to_string()
			solution: "31839939622"
		},
		Solver{
			name: 'Day 02 B'
			func: day02.solve_b
			data: day02_a_embed.to_string()
			solution: "41662374059"
		},
		Solver{
			name: 'Day 03 A'
			func: day03.solve_a
			data: day03_a_embed.to_string()
			solution: "17524"
		},
		Solver{
			name: 'Day 03 B'
			func: day03.solve_b
			data: day03_a_embed.to_string()
			solution: "173848577117276"
		},
		Solver{
			name: 'Day 04 A'
			func: day04.solve_a
			data: day04_a_embed.to_string()
			solution: "1433"
		},
		Solver{
			name: 'Day 04 B'
			func: day04.solve_b
			data: day04_a_embed.to_string()
			solution: "8616"
		},
		Solver{
			name: 'Day 05 A'
			func: day05.solve_a
			data: day05_a_embed.to_string()
			solution: "848"
		},
		Solver{
			name: 'Day 05 B'
			func: day05.solve_b
			data: day05_a_embed.to_string()
			solution: "334714395325710"
		},
		Solver{
			name: 'Day 06 A'
			func: day06.solve_a
			data: day06_a_embed.to_string()
			solution: "6417439773370"
		},
		Solver{
			name: 'Day 06 B'
			func: day06.solve_b
			data: day06_a_embed.to_string()
			solution: "11044319475191"
		},
	]

	for s in solvers {
		start := time.sys_mono_now()
		result := s.func(s.data) or {
			eprintln('Error solving ${s.name}: ${err}')
			continue
		}
		elapsed_ns := time.sys_mono_now() - start
		elapsed_ms := f64(elapsed_ns) / 1_000_000.0
		solution := s.solution or { 'undefined' }
		println('${s.name} -> ${result} == ${solution} match: ${result == solution} in ${elapsed_ms:.3f} ms')
	}
}
