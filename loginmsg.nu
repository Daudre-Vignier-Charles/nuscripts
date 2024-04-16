let $sys = sys
{
    "username": $"(whoami)"
    "hostname": $"($sys.host.hostname)"
    "uptime" : $"($sys.host.uptime)"
    "operating-system": $"($sys.host.name)"
    "CPU": $"($sys.cpu.brand.0) - ($sys.cpu | length | into string) core\(s\)"
    "RAM": $"($sys.mem.total)"
}
