module day03

const data_a = "987654321111111\n811111111111119\n234234234234278\n818181911112111"


fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }
    assert result == "357"
}

fn test_solve_b() {
    result := solve_b(data_a) or { panic(err) }
    assert result == "3121910778619"
}
