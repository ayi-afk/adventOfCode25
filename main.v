module main

import time
import day01

type SolverFn = fn (string) !string

const day01_a_embed = $embed_file('day01/day01_A.txt')
const day01_b_embed = $embed_file('day01/day01_B.txt')

struct Solver {
	name     string
	func     SolverFn @[required]
	data     string
	solution ?string
}

fn main() {
	solvers := [
		Solver{
			name: 'Day 01 A'
			func: day01.solve_a
			data: day01_a_embed.to_string()
		},
		Solver{
			name: 'Day 01 B'
			func: day01.solve_b
			data: day01_b_embed.to_string()
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
