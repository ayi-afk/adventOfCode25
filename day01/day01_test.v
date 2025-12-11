module day01

const data_a = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"


fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }    
    assert result == "3"
}

fn test_solve_b() {
    result := solve_b(data_a) or { panic(err) }    
    assert result == "6"
}
