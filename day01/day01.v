module day01

const dial_size = 100

enum Direction {
	l = -1
	r = 1
}

struct DialCode {
	direction Direction
	power int
}

struct Dial {	
mut:
    value int = 50    
    password int
	password_total int
}

fn (mut d Dial) rotate(dial_code DialCode) {		
    steps := dial_code.power
    dir := int(dial_code.direction)
	// part B
	// todo
    d.password_total += 0

	// part A
    d.value += steps * dir
    d.value = ((d.value % dial_size) + dial_size) % dial_size
    if d.value == 0 {
        d.password++
    }
}

fn create_dial_code(code string) !DialCode {
	if code.len < 2 {
		return error("Error code cannot be less than 2 chars")
	}
	direction_char := code[0].ascii_str()
	power := code[1..].int()
	direction := match direction_char {
		'L' {Direction.l}
		'R' {Direction.r}
		else {
			return error("ukjnown direction ${direction_char}")
		}
	}
	return DialCode {
		direction: direction
		power: power
	}
}

fn prepare(data string) ![]DialCode {
	directions_strs := data.split('\n').filter(it.len > 0)
	mut directions := []DialCode{}
    for str in directions_strs {
    	directions << create_dial_code(str)!
    }
    
	return directions
}

pub fn solve_a(data string) !string {
	directions := prepare(data)!
	mut dial := Dial{}
    for d in directions {
		dial.rotate(d)
	} 
	return dial.password.str()
}

pub fn solve_b(data string) !string {
	directions := prepare(data)!
	mut dial := Dial{}
    for d in directions {
		dial.rotate(d)
	} 	

	return dial.password_total.str()
}
