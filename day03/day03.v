module day03

import arrays

fn find_joltage(batteries []int) int {
    if batteries.len < 2 {
        return 0
    }     
    mut max1 := 0    
    mut max1_idx := 0    
    for idx, bat in batteries[..batteries.len-1] {        
        if bat > max1 {
            max1_idx, max1 = idx, bat
        }
    }    
    
    max2 := arrays.max(batteries[max1_idx+1 ..]) or { -1 }
    total_joltage := max1 * 10 + max2
    return total_joltage
}

fn find_mega_joltage(batteries []int) u64 {
    if batteries.len < 12 {
        return 0 
    }

    mut remove := batteries.len - 12
    mut st := []int{cap: batteries.len}

    for d in batteries {
        for remove > 0 && st.len > 0 && st[st.len - 1] < d {
            st.delete_last()
            remove--
        }
        st << d
    }

    for remove > 0 {
        st.delete_last()
        remove--
    }

    mut x := u64(0)
    for i := 0; i < 12; i++ {
        x = x * 10 + u64(st[i])
    }
    return x
}


pub fn solve_a(data string) !string {
    banks := data.split('\n')    
    mut sum := 0
    for bank in banks {
        batteries := bank.runes().map(int(it - `0`))            
        sum += find_joltage(batteries)  
    }

    return sum.str()
}

pub fn solve_b(data string) !string {
    banks := data.split('\n')    
    mut sum := u64(0)
    for bank in banks {
        batteries := bank.runes().map(int(it - `0`))            
        sum += find_mega_joltage(batteries)  
    }

    return sum.str()
}