# Record keys become values and values become keys 
export def reversekv [record?: record]: record -> record {
    let $piperec = | into record
    mut $rec = {}
    if ($record | is-empty) {
        $rec = $piperec
    } else {
        $rec = $record
    }
    mut $out = {}
    for $i in ($rec | transpose) {
        $out = ($out | merge {$i.column1: $i.column0})
    }
    $out
}
 