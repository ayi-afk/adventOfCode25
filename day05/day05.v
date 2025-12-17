module day05

struct Range {
pub:
    start u64
    end u64
}

@[inline]
fn (r Range) in(n u64) bool {
    return r.start <= n && n <= r.end
}

// Here i was fighting i wantes types that are arrays but sort methods could not 
// be dispatched is it V error or i did something wrong o.O and it's really late now ;(

// Returns:
//  0  if n is inside [start, end]
// -1  if n is before the range
//  1  if n is after the range
@[inline]
fn (r Range) cmp(n u64) i8 {
    if n < r.start {
        return -1
    }
    if n > r.end {
        return 1
    }
    return 0
}

type Ranges = []Range

fn (mut r []Range) sort_by_start() {
    r.sort_with_compare(fn (a &Range, b &Range) int {
        if a.start < b.start { return -1 }
        if a.start > b.start { return 1 }
        return 0
    })
}

type Id = u64  // wierd bug with some dispatching then typing as []u64

fn (mut ids []Id) sort_asc() {
    ids.sort()
}

// Returns:
// sorted Ranges and IDs
fn prepare(data string) ([]Range, []Id) {
    
    ranges_str, ids_str := data.split_once("\n\n") or { 
        eprintln("Nothing found")
        return []Range{}, []Id{} 
    }
    
    mut ranges := []Range{cap: ranges_str.count('\n') + 1}
    mut ids := []Id{cap: ids_str.count('\n') + 1}

    for r in ranges_str.split_into_lines() {
        ab := r.split('-')
         
        ranges << Range{ 
            start: ab[0].u64()
            end:   ab[1].u64()
        }
    }
    for id in ids_str.split_into_lines() {
        ids << id.u64()
    }
    ranges.sort_by_start()
    ids.sort_asc()    
    return ranges, ids
}

// Returns:
// Copy of ranges where overlaping ones are merged
fn (ranges []Range) merged_ranges() []Range {
    mut current := ranges[0]
    mut merged := []Range{cap: ranges.len}

    for i in 1..ranges.len {
        range := ranges[i]
        if range.start <= current.end + 1 {
            if range.end > current.end {
                current = Range{ start: current.start, end: range.end }
            }            
        } else {
            merged << current
            current = range
        }
    }
    merged << current
    return merged
}

pub fn solve_a(data string) !string {
    mut ranges, ids := prepare(data)
    mut total := 0
    mut last_check := 0
    for id in ids {
        for rid in last_check..ranges.len {
            range := ranges[rid]
            if range.in(id) {
                total++
                break // go to next id
            }
            cmp := range.cmp(id)
            if cmp == 1 {
                last_check = rid + 1
                continue // check next range
            }             
            if cmp == -1 {
                break // no need to check later ranges
            }
        }
        if last_check >= ranges.len {
            break
        }        
    }
    return total.str()
}

pub fn solve_b(data string) !string {
    mut ranges, _ := prepare(data)
    merged := ranges.merged_ranges()
    mut total := u64(0)
    for m in merged {
        total += m.end - m.start + 1
    }
    return total.str()
}