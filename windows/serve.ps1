# Cybrix 16 Mapper - tiny local web server for Windows (no install needed).
# Serves index.html on http://localhost:8716 so Chrome/Edge can use WebHID.
$ErrorActionPreference = "Stop"
$root  = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$index = Join-Path $root "index.html"
$port  = 8716
$url   = "http://localhost:$port/"

function Open-Browser {
  $candidates = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
  ) | Where-Object { $_ -and (Test-Path $_) }
  if ($candidates) { Start-Process -FilePath $candidates[0] -ArgumentList $url }
  else { Start-Process "msedge.exe" -ArgumentList $url }
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
try { $listener.Start() } catch {
  # Already running (opened before) - just open the browser again.
  Open-Browser; exit
}
Open-Browser

# Only index.html is ever served; any other path gets the same page.
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  try {
    $bytes = [System.IO.File]::ReadAllBytes($index)
    $ctx.Response.ContentType = "text/html; charset=utf-8"
    $ctx.Response.Headers.Add("Cache-Control", "no-store")
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } catch {
    $ctx.Response.StatusCode = 500
  } finally {
    $ctx.Response.Close()
  }
}
