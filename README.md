# driveinfos
Retrieve volumes returned by Win32 Volume

Powershell script used by the agent gets drives from win32_logicaldisk (already returned by the agent core) and win32_volume, and compares the outputs.
If entries in  win32_volume are not found in win32_logicaldisk output, they are added to the plugin's data.