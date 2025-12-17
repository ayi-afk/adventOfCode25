module day05

const data_a = "3-5\n10-14\n16-20\n12-18\n\n1\n5\n8\n11\n17\n32"


fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }
    assert result == "3"
}

fn test_solve_b() {
    result := solve_b(data_a) or { panic(err) }
    assert result == "answer"
}
