param([string]$Julia='julia')
$ErrorActionPreference='Stop'
$codeRoot=$PSScriptRoot
function Run-JuliaStep([string[]]$JuliaArgs) {
    & $Julia @JuliaArgs
    if ($LASTEXITCODE -ne 0) { throw ('Julia failed: '+($JuliaArgs -join ' ')) }
}
Run-JuliaStep @('--version')
for ($caseId=1; $caseId -le 8; $caseId++) {
    Write-Output ('=== DEMO '+$caseId+' ===')
    Run-JuliaStep @('--startup-file=no',(Join-Path $codeRoot 'demo.jl'),('--ca='+$caseId))
}
Run-JuliaStep @('--startup-file=no',(Join-Path $codeRoot 'test/runtests.jl'))
Write-Output 'END_TO_END_OK: demos and tests completed.'
