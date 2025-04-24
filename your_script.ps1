param (
    [string]$Target = "10.65.1.5"
)

$timestamp = Get-Date -Format "o"
$result = "unknown"
$reachable = $false

try {
    $pingResult = Test-Connection -ComputerName $Target -Count 1 -Quiet
    if ($pingResult) {
        $reachable = $true
        $result = "success"
    } else {
        $result = "failed"
    }
} catch {
    $result = "error"
}

$log = @{
    target      = $Target
    status      = $result
    reachable   = $reachable
    source      = $env:COMPUTERNAME
    check_type  = "icmp"
    timeoflog   = $timestamp
}

# Output JSON to file or stdout
$log | ConvertTo-Json -Depth 2 -Compress | Out-File -FilePath "C:\logs\connectivity\connectivity.log" -Encoding utf8

