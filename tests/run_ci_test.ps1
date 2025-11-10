try {
    # Ensure script runs in WSL for consistent behavior
    $scriptPath = $MyInvocation.MyCommand.Path
    $scriptDir  = Split-Path -Parent $scriptPath
    # repo root is parent of the tests directory (script is in tests)
    $projectRoot = Split-Path -Parent $scriptDir

    # Convert Windows path to WSL path: C:\foo -> /mnt/c/foo
    $wslPath = $projectRoot -replace '\\','/'
    if ($wslPath -match '^([A-Za-z]):') {
        $drive = $matches[1].ToLower()
        $wslPath = $wslPath -replace '^[A-Za-z]:', "/mnt/$drive"
    }

    $wslCommand = "cd '$wslPath' && ./tests/run_ci_test.sh"
    Write-Host "Running in WSL: $wslCommand"
    wsl.exe bash -lc $wslCommand
} catch {
    Write-Error "Failed to run test: $_"
}

Write-Host "`nPress any key to close..."
[System.Console]::ReadKey() | Out-Null
