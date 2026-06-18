# Grabber.cy summary

`BloatlessLauncher.exe` is a Windows sample with a reported score of `8/10` and a behavior set that looks strongly loader-like. The observed run began from `%TEMP%`, spawned PowerShell, and downloaded `legendary.exe` via `Invoke-WebRequest` before writing it to `C:\Windows\System32\legendary.exe`.

The surrounding activity is what makes the sample interesting from a defender's perspective. The report shows registry and BIOS probing, SCSI enumeration, system language discovery, VirtualBox artifact checks, process enumeration, privilege adjustments, and memory write activity.

## Useful network facts

- GitHub release infrastructure was used to fetch `legendary.exe`
- `anondrop.net`, `doxbin.com`, `doxbin.net`, `ethereum.publicnode.com`, and `servus.doxbin.cy` were contacted during the run
- The report includes `POST` requests to several of those services, not just DNS lookups

## Defensive takeaway

The cleanest detection opportunity is the PowerShell download-and-drop pattern into a Windows system directory. The next strongest signal is the follow-on discovery logic, which gives analysts a better reason to group the activity as a single malicious workflow.
