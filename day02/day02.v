module day02


struct Range {
    a u64
    b u64
}

type Ranges = []Range

fn prepare(data string) !Ranges {
    mut ranges := Ranges{}
    for pairs in data.split(',') {
        pair := pairs.split('-')
        if pair.len != 2 {
            return error('Invalid pair: $pairs')
        }        
        ranges << Range{a: pair[0].u64(), b: pair[1].u64()}
    }
    return ranges
}

fn is_invalid_a(number u64) bool {
    s := number.str()
    if s.len % 2 != 0 {        
        return false
    }
    half := s.len / 2
    first := s[..half]
    second := s[half..]
    return first == second
}

pub fn solve_a(data string) !string {
    ranges := prepare(data)! 
    mut sum_ids := u64(0)
    for r in ranges {
        for n in r.a .. r.b + 1 {            
            if is_invalid_a(n) {                
                sum_ids +=  n
            }
        }

    }
        
    return sum_ids.str()
}

@[inline]
fn is_invalid_b(number u64) bool {
    s := number.str()
    if s.len < 2 {    
        return false
    }    
    for size := 1; size <= s.len / 2; size++ {        
        if s.len % size != 0 {
            continue
        }
        pattern := s[..size]
        mut ok := true        
        for i := size; i < s.len; i += size {
            if s[i..i + size] != pattern {
                ok = false
                break
            }
        }
        if ok {            
            return true
        }
    }
    return false

}

pub fn solve_b(data string) !string {
    ranges := prepare(data)! 
    mut sum_ids := u64(0)
    for r in ranges {
        for n in r.a .. r.b + 1 {            
            if is_invalid_b(n) {                
                sum_ids +=  n
            }
        }

    }
        
    return sum_ids.str()
}