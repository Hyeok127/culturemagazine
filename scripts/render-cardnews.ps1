<#
.SYNOPSIS
  카드뉴스 HTML(?card=1..8)을 헤드리스 Chrome으로 1080×1350 PNG 8장으로 렌더한다.

.EXAMPLE
  .\scripts\render-cardnews.ps1 -Html .\cardnews\interstellar-organ.html -Prefix interstellar-organ
#>
param(
  [Parameter(Mandatory = $true)] [string] $Html,
  [Parameter(Mandatory = $true)] [string] $Prefix,
  [int] $Count = 8,
  [string] $OutDir = (Join-Path $PSScriptRoot "..\cardnews\out")
)

$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
if (-not (Test-Path $chrome)) { $chrome = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" }
if (-not (Test-Path $chrome)) { throw "Chrome 또는 Edge를 찾지 못했습니다." }

$htmlFull = (Resolve-Path $Html).Path
$OutDir = (New-Item -ItemType Directory -Force $OutDir).FullName
# 실행 중인 브라우저와 프로필이 겹치면 캡처가 되지 않으므로 전용 임시 프로필을 쓴다
$profile = Join-Path $env:TEMP "algobomyeon-cardnews-profile"
New-Item -ItemType Directory -Force $profile | Out-Null

$fileUrl = "file:///" + ($htmlFull -replace '\\', '/')
foreach ($i in 1..$Count) {
  $png = Join-Path $OutDir ("{0}-{1:D2}.png" -f $Prefix, $i)
  & $chrome --headless=new --disable-gpu --hide-scrollbars --window-size=1080,1350 `
    --virtual-time-budget=8000 --user-data-dir="$profile" --screenshot="$png" "$fileUrl?card=$i" 2>$null | Out-Null
  Write-Host ("[{0}/{1}] {2}" -f $i, $Count, $png)
}
