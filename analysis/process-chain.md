# Process chain

## Observed processes

| Process | Notes |
| --- | --- |
| `BloatlessLauncher.exe` | Main sample executed from `%TEMP%` |
| `original_335150.exe` | Parent/dropped executable referenced in the report |
| `cmd.exe` | Used to launch a temporary batch script |
| `powershell.exe` | Performed the download of `legendary.exe` |

## Sequence

| Step | Behavior |
| --- | --- |
| 1 | The sample started in `C:\Users\Admin\AppData\Local\Temp\BloatlessLauncher.exe` |
| 2 | A temporary batch file launched `original_335150.exe` |
| 3 | PowerShell executed `Invoke-WebRequest` against GitHub release infrastructure |
| 4 | The payload was written as `C:\Windows\System32\legendary.exe` |
| 5 | Follow-on discovery included registry, BIOS, SCSI, language, and VirtualBox checks |

## Why the chain matters

The chain shows a loader-like workflow. The download location, the destination path, and the follow-on reconnaissance all point to behavior that defenders should treat as a single campaign rather than isolated events.
