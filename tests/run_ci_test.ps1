try {
    # Ensure script runs in WSL for consistent behavior
    $projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    $wslPath = $projectPath -replace '\\','/' -replace '^([A-Za-z]):','/mnt/$1'.ToLower()
    $wslCommand = "cd '$wslPath' && ./tests/run_ci_test.sh"
    Write-Host "Running in WSL: $wslCommand"
    wsl.exe bash -lc $wslCommand
} catch {
    Write-Error "Failed to run test: $_"
}

Write-Host "\nPress any key to close..."
[System.Console]::ReadKey() | Out-Null
