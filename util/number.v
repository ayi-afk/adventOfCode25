module util

pub fn to_number(column []u64) u64 {
    mut num := u64(0)
    mut pow := u64(1)

    for c in column {
        num += c * pow
        pow *= 10
    }
    return num
}