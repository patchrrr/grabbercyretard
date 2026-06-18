# ATT&CK mapping

| Technique | Evidence in the report | Why it matters |
| --- | --- | --- |
| `T1059.001` PowerShell | `Invoke-WebRequest` launched in a PowerShell process | Common delivery and staging mechanism |
| `T1012` Query Registry | SCSI and BIOS registry keys were queried | Often used for discovery and environment checks |
| `T1082` System Information Discovery | BIOS, storage, and VM-related artifacts were enumerated | Helps the sample profile the host |
| `T1120` Peripheral Device Discovery | Physical storage and optical drive checks appeared | Often seen in sandbox or VM probing |
| `T1614.001` System Language Discovery | Language registry values were queried | Can help infer locale or region |

## Secondary signals

- `SeDebugPrivilege` and `SeSystemEnvironmentPrivilege` use appeared in the report
- Process enumeration and write-process-memory activity were noted
- VirtualBox artifacts suggest anti-analysis awareness
