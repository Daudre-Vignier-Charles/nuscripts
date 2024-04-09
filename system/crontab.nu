def nucrontab [--user (-u): string --overwrite (-o)] {
    let $content = | print
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
