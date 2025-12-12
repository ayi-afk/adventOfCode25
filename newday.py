from pathlib import Path
import shutil
import re
import os

DAY_DIR_RE = re.compile(r"^day(\d+)$")
NUM_WIDTH = 2 # how many digits in filename

def get_last_number() -> int:
    max_number = -1

    for entry in Path(".").iterdir():
        if not entry.is_dir():
            continue

        name = entry.name
        if not name.startswith("day"):
            continue

        suffix = name[3:]
        if not suffix.isdigit():
            continue

        number = int(suffix)
        max_number = max(max_number, number)

    if max_number == -1:
        raise RuntimeError("No dayNN directories found")

    return max_number

def rename_files(dir: Path, number: int) -> None:

    new_token = f"day{number:0{NUM_WIDTH}d}"
    plans: list[tuple[Path, Path]] = []
    for p in dir.iterdir():
        if not p.is_file():
            continue
        if "dayN" not in p.name:
            continue

        target = p.with_name(p.name.replace("dayN", new_token))
        plans.append((p, target))

    for src, dst in plans:
        src.rename(dst)

def replace_module_name(dir: Path, number: int) -> None:
    
    
    if not dir.is_dir():
        raise NotADirectoryError(dir)

    new_mod = f"day{number:0{NUM_WIDTH}d}"

    module_line_re = re.compile(r"^(\s*module\s+)dayN(\s*)$", re.MULTILINE)

    for vf in dir.rglob("*.v"):        
        text = vf.read_text(encoding="utf-8")
        new_text, count = module_line_re.subn(rf"\1{new_mod}\2", text)
        if count > 0:
            print(f"Editing {vf.name}")
            vf.write_text(new_text, encoding="utf-8")
        

def main() -> None:
    last_number = get_last_number()
    current_number = last_number + 1
    new_dir_name = f"day{current_number:0{NUM_WIDTH}d}"
    new_dir = Path(new_dir_name)


    print(f"copying ./dayN -> {new_dir_name}")
    shutil.copytree(Path("dayN"), new_dir_name)

    rename_files(new_dir, current_number)
    replace_module_name(new_dir, current_number)
    os.system(f"v test {new_dir_name}")
    


if __name__ == "__main__":
    main()