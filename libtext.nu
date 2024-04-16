export def delcom [] {
    $in | find -v -m -r "^[\\s]*#.*$"
}

export def lopen [file : string] {
    open $file | lines
}

