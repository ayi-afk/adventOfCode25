module main

import time
import day01
import day02

type SolverFn = fn (string) !string

const day01_a_embed = $embed_file('day01/day01_A.txt')
const day02_a_embed = $embed_file('day02/day02_A.txt')


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
