module day06

const data_a = "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  "


fn test_solve_a() {
    result := solve_a(data_a) or { panic(err) }
    assert result == "4277556"
}

fn test_solve_b() {
    result := solve_b(data_a) or { panic(err) }
    assert result == "3263827"
}
