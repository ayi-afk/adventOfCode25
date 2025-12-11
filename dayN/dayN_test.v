module dayN

const (
    data_a = ""
    data_b = ""
)

fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }
    assert result == "X"
}

fn test_solve_b() {
    result := solve_b(data_b) or { panic(err) }
    assert result == "X"
}
