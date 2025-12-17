module day06
import util

enum Operator {
    mul 
    add 
    sub 
    div 
}
fn parse_op(s string) Operator {
    return match s {
        "+" { .add }
        "-" { .sub }
        "*" { .mul }
        "/" { .div }
        else { panic('invalid operator') }
    }
}


fn prepare(data string) ([][]u64, []Operator) {    
    lines := data.split_into_lines()    
    if lines.len == 0 {
        panic("wrong data")            
    }
    mut rows := [][]u64{cap: lines.len -1}
    for i in 0..lines.len-1 {
        rows << lines[i].fields().map(it.u64())
    }
    operators := lines[lines.len-1].fields().map(parse_op(it))

    return rows, operators

}

fn prepare_b(data string) ([][]u64, []Operator) {    
    lines := data.split_into_lines()    
    if lines.len == 0 {
        panic("wrong data")            
    }
    operators := lines[lines.len-1].fields().map(parse_op(it))

    mut rows := [][]u64{len: operators.len}
    mut big_x := operators.len - 1
    for x := lines[0].len -1; x >= 0; x--{
        mut nums := []u64{cap: lines.len-1}
        for y in 0..lines.len-1 {            
            if x >= lines[y].len {
                nums << 0                
                continue
            }
            c := lines[y][x] // c for character too late to invent better name
            n := if c >= `0` && c <= `9` { u64(c - `0`) } else { 0 }            
            nums << n
        }
        num := util.to_number(nums.filter(it > 0).reverse())                        
        if num > 0 {
            rows[big_x] << num
        }
        else {            
            big_x -= 1
        }
        
    }
    return rows, operators
}

pub fn solve(rows [][]u64, operators []Operator) u64 {    
    mut total := u64(0)
    for x in 0..rows[0].len {
        op := operators[x]        
        mut local := match op {
            .mul, .div { u64(1) }
            else { u64(0) }
        }        
        for y in 0..rows.len {
            current := u64(rows[y][x])
            match op {
                .mul { local *= current }
                .add { local += current }
                .sub { local -= current }
                .div { local /= current }
            }            
        }        
        total += local
    }
    return total
}

pub fn solve_a(data string) !string {
    rows, operators := prepare(data)
    return solve(rows, operators).str()
}

pub fn solve_b(data string) !string {    
   rows, operators := prepare_b(data)
   mut total := u64(0)
   for i in 0..operators.len {    
    op := operators[i]
    mut local := match op {
            .mul, .div { u64(1) }
            else { u64(0) }
    }
    for num in rows[i] {
        match op {
            .mul { local *= num}
            .add { local += num}
            else {
                panic("something wrong")
            } 
        }   
    }
    total += local    
   }
   return total.str()
}
//i really messaed that i tought clean and nice solution and i just make it too much complicated(but i'm still learning language so not too much love for this alghoritms)