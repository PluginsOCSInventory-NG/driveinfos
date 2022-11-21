# script retrieves drives from win32_logicaldisk and win32_volume
# both outputs are compared, if entries in  win32_volume are not found in win32_logicaldisk output,
# they are added to returned data
$drives = Get-WmiObject -Class Win32_LogicalDisk | select DeviceID
$volumes = Get-WmiObject Win32_Volume

# both drives and volumes are not empty
if ($drives -and $volumes) {
	foreach ($volume in $volumes) {
		foreach ($drive in $drives) {
			$match = 1
			# drive letter does not equal volume letter or drive letter is empty
			if ( $drive.DeviceID -eq "" -or $drive.DeviceID -ne $volume.DriveLetter) {
				$match = 0
			# volume does correspond to a drive
			} else {
				break
			}
		}

		if ($match -eq 0) {
			# translate numeric drive type to string value
			switch ($volume.DriveType) {
				0 { $driveType = "Unknown" }
				1 { $driveType = "No Root Directory" }
				2 { $driveType = "Removable Disk" }
				3 { $driveType = "Local Disk" }
				4 { $driveType = "Network Drive" }
				5 { $driveType = "Compact Disc" }
				6 { $driveType = "RAM Disk" }
			}

			# get driveletter
			if ($volume.DriveLetter -eq '' -or $volume.Name -match "^[A-Z]:") {
				$driveLetter = $Matches.0
			} else {
				$driveLetter = ""
			}


			$xml += "<DRIVEINFOS>`n"
			$xml += "<NAME>"+ $volume.name +"</NAME>`n"
			$xml += "<LABEL>"+ $volume.label +"</LABEL>`n"
			$xml += "<DRIVETYPE>"+ $driveType +"</DRIVETYPE>`n"
			$xml += "<DRIVELETTER>"+ $driveLetter +"</DRIVELETTER>`n"
			$xml += "<FILESYSTEM>"+ $volume.FileSystem +"</FILESYSTEM>`n"
			$xml += "<CAPACITY>"+ ($volume.Capacity /1MB) +"</CAPACITY>`n"
			$xml += "<FREESPACE>"+ ($volume.FreeSpace /1MB) +"</FREESPACE>`n"
			$xml += "</DRIVEINFOS>`n"
		}	
	}
} else {
	$xml += "<DRIVEINFOS />"
}
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)
