export def stat [file: string] {
    ^stat --format '{
    "filename" : "%n",
    "filetype": "%F",
    "owner": "%U",
    "ownerid": "%u",
    "ownergroup": "%G",
    "ownergroupid": "%g",
    "rightshuman": "%A",
    "rightsoctal": "%a",
    "creationdate": "%w",
    "creationtime": "%W",
    "lastaccessdate": "%x",
    "lastaccesstime": "%X",
    "lastmodificationdate": "%y",
    "lastmodificationtime": "%Y",
    "lastchangedate": "%z",
    "lastchangetime": "%Z",
    "inode": "%i",
    "blocks": "%b",
    "blockssize": "%B",
    }' $file | from json
}

export def nucrontab [--user (-u): string --overwrite (-o)] {
    let $content = $in
    const $headers: string = "minute\thour\tmonthday\tmonth\tweekday\tcommand\n"

    if ($user | is-empty) {
        $user = whoami
    }

    if ($content | is-empty) {
        let $content = crontab -u $user -l | complete

        if $content.exit_code == 1 {
            print -e $content.stderr
            return
        }

        let $out = $headers + $content.stdout |
                lines |
                find -v -m -r "^[\\s]*#.*$" |
                str replace -r -m "^([0-9*]*) ([0-9*]*) ([0-9*]*) ([0-9*]*) ([0-9*]*) (.*)$" "${1}\t${2}\t${3}\t${4}\t${5}\t${6}"

        $out | split column "\t" | headers
    } else {
        
    }
}

# Convert octal Unix modes
# If provided Unix mode is octal, it will be converted to text
# If provided Unix mode is text, it will be converted to octal
export def cvchmod [
        mode: string # Octal or text Unix mode
    ]: nothing -> string {
    const $nmap = {
        "r": 4
        "w": 2
        "x": 1
        "-": 0
    }
    const $tmap = {
        "0": "---"
        "1": "--x"
        "2": "-w-"
        "3": "-wx"
        "4": "r--"
        "5": "r-x"
        "6": "rw-"
        "7": "rwx"
    }

    mut $mode = $mode
    if $mode =~ "^[0-7]{3}$" {
        mut $strmode = ""
        for $char in ($mode | split chars) {
            $strmode += ($tmap | get $char)
        }
        $strmode
    } else if $mode =~ "^([r-][w-][x-]){3}$" {
        mut $num = 0
        mut $strmode = ""
        let $smode = ($mode | split chars)
        let $mode = [$"($smode.0)($smode.1)($smode.2)" $"($smode.3)($smode.4)($smode.5)" $"($smode.6)($smode.7)($smode.8)"]
        for $group in $mode {
            for $char in ($group | split chars) {
                $num += ($nmap | get $char)
            }
            $strmode += ($num | into string)
            $num = 0
        }
        $strmode
    } else {
        print $"($mode) : Unrecognized mod format"
    }
}
