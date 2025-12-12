module day02


const data = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

fn test_solve_a() {
    result := solve_a(data) or { panic(err) }
    assert result == "1227775554"
}

fn test_solve_b() {
    result := solve_b(data) or { panic(err) }
    assert result == "X"
}
