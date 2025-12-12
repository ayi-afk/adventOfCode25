module dayN

const data_a = ""


fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }
    assert result == "answer"
}

fn test_solve_b() {
    result := solve_b(data_a) or { panic(err) }
    assert result == "answer"
}
