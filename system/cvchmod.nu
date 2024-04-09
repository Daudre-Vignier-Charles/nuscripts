def cvchmod [mode] {
    const $map = {
        "r": 4
        "w": 2
        "x": 1
        "-": 0
    }

    mut $mode = $mode
    if ($mode | describe) == "int" {
        $mode = ($mode | into string)
    }
    if $mode =~ "[0-7]{3}" { 
        print numeric
    } else if $mode =~ "([r-][w-][x-]){3}" {
        mut $num = 0
        mut $strmode = ""
        let $smode = ($mode | split chars)
        let $mode = [$"($smode.0)($smode.1)($smode.2)" $"($smode.3)($smode.4)($smode.5)" $"($smode.6)($smode.7)($smode.8)"]
        for $group in  $mode {
            for $char in ($group | split chars) {
                $num += ($map | get $char)
            }
            $strmode += ($num | into string)
            $num = 0
        }
        $strmode
    } else {
        print $"($mode) : Unrecognized mod format"
    }
}
