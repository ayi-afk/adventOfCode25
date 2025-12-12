module day04

import util


fn build_grid(lines []string) [][]u8 {
    // adding padding like in image processing
    h, w := lines.len, lines[0].len
    
    mut grid := [][]u8{len: h + 2, init: []u8{len: w + 2}}

    for y in 0..h {
        for x in 0..w {
            grid[y + 1][x + 1] = u8(lines[y][x] == `@`)
        }
    }
    return grid
}

fn count_pickable_rolls(grid [][]u8, max_neightbors_to_pickup int) int {
    mut count := 0
    h, w := grid.len, grid[0].len
    
    // iterate only over the original cells
    for y := 1; y < h - 1; y++ {
        for x := 1; x < w - 1; x++ {
            if grid[y][x] == 0 {
                continue
            }

            s :=
                grid[y-1][x-1] + grid[y-1][x] + grid[y-1][x+1] +
                grid[y][x-1] + grid[y][x+1] + grid[y+1][x-1] + 
                grid[y+1][x] + grid[y+1][x+1]

            if s < max_neightbors_to_pickup {
                count++
            }
        }
    }
    return count
}

fn count_big_removal(mut grid [][]u8, max_neightbors_to_pickup u8, removed int) int {
    mut count := 0
    h, w := grid.len, grid[0].len

    mut to_remove := [][2]int{} 

    for y := 1; y < h - 1; y++ {
        for x := 1; x < w - 1; x++ {
            if grid[y][x] == 0 {
                continue
            }

            s :=
                grid[y-1][x-1] + grid[y-1][x] + grid[y-1][x+1] +
                grid[y][x-1] + grid[y][x+1] + grid[y+1][x-1] + 
                grid[y+1][x] + grid[y+1][x+1]

            if s < max_neightbors_to_pickup {
                to_remove << [x, y]!
                count++
            }
        }
    }

     for pt in to_remove {
        x := pt[0]
        y := pt[1]
        grid[y][x] = 0
    }

    
    if count == 0 {
        return removed
    }
    else {
        return count_big_removal(mut grid, max_neightbors_to_pickup, removed + count)
    }

}

pub fn solve_a(data string) !string {
    lines := util.prepare(data)
    grid := build_grid(lines)
    count := count_pickable_rolls(grid, 4)
    return count.str()
}

pub fn solve_b(data string) !string {
    lines := util.prepare(data)
    mut grid := build_grid(lines)
    count := count_big_removal(mut grid, 4, 0)
    return count.str()
}