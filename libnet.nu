use libtext.nu

export def getmyip [] {
    {IPv4: (dig +short myip.opendns.com A @resolver1.opendns.com), IPv6: (dig +short myip.opendns.com AAAA @resolver1.opendns.com)}
}

# List, add and delete DNS servers
export def "net dns" [] {
}

# List DNS servers
export def "net dns list" [] {
    (libtext lopen /etc/resolv.conf | libtext delcom |  split column " ").column2
}

# Add DNS servers
export def "net dns add" [server?: list<string>] list <string> -> list<string> {
    #
}

# Delete DNS servers
export def "net dns del" [server?: list<string>] list<string> -> list<string> {
    #
}

# List, add and delete network routes
export def "net route" [] {
}

# List network routes
export def "net route list" [] nothing -> list<any> {   
    ip --json route list | from json
}

# Add network routes
export def "net route add" [destination?: string, gateway?: string, metric=0: int] record -> list<any> {   
    #
}

# Delete network routes
export def "net route del" [destination?: string, gateway?: string] record -> list<any> {   
    #
}
