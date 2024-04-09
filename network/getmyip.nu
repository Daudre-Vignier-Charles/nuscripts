def getmyip [] {
    {IPv4: (dig +short myip.opendns.com A @resolver1.opendns.com), IPv6: (dig +short myip.opendns.com AAAA @resolver1.opendns.com)}
}
