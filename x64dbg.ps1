# x64dbg setup

[Net.ServicePointManager]::SecurityProtocol = 'Tls12, Tls11, Tls'

# Installs x64dbg under %LOCALAPPDATA% (typically C:\Users\%USERNAME%\AppData\Local)
$destination = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'x64dbg'

# Installs x64dbg
if (!(Test-Path (Join-Path -Path $destination -ChildPath 'release\x96dbg.exe'))) {
	$release = '2019-01-20_22-50'
	$installer = Join-Path -Path $env:temp -ChildPath ('snapshot_' + $release + '.zip')
	Invoke-WebRequest -Uri ('https://github.com/x64dbg/x64dbg/releases/download/snapshot/snapshot_' + $release + '.zip') -OutFile $installer
	if (Test-Path $installer) {
		Expand-Archive $installer -DestinationPath $destination
	}
}

# Installs Python 2.7 for all users into C:\Python27
if (!(Test-Path 'C:\Python27\python.exe')) {
	$release = '2.7.15'
	$installer = Join-Path -Path $env:temp -ChildPath ('python-' + $release + '.msi')
	Invoke-WebRequest -Uri ('https://www.python.org/ftp/python/2.7.15/python-' + $release + '.msi') -OutFile $installer
	if (Test-Path $installer) {
		$arguments = '/i ' + $installer + ' /qb ALLUSERS=1'
		Start-Process msiexec.exe -ArgumentList $arguments -Wait
	}
}

if (!(Test-Path (Join-Path -Path $destination -ChildPath 'release\x32\plugins\x64dbgpy.dp32'))) {
	# Adds x64dbgpy support
	$release = 'h5xgmr7x5v80voae'
	$installer = Join-Path -Path $env:temp -ChildPath 'release.zip'
	Invoke-WebRequest -Uri ('https://ci.appveyor.com/api/buildjobs/' + $release + '/artifacts/release.zip') -OutFile $installer
	if (Test-Path $installer) {
		Expand-Archive $installer -DestinationPath (Join-Path -Path $destination -ChildPath 'release')
	}
	Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/x64dbg/x64dbgpylib/master/pykd.py' -OutFile (Join-Path -Path $destination -ChildPath 'release\x32\plugins\x64dbgpy\pykd.py')
	Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/x64dbg/x64dbgpylib/master/x64dbgpylib.py' -OutFile (Join-Path -Path $destination -ChildPath 'release\x32\plugins\x64dbgpy\x64dbgpylib.py')
	# Adds x32dbg mona support
	Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/x64dbg/mona/master/clean_mona.py' -OutFile (Join-Path -Path $destination -ChildPath 'release\x32\plugins\x64dbgpy\x64dbgpy\autorun\clean_mona.py')
	Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/x64dbg/mona/master/mona.py' -OutFile (Join-Path -Path $destination -ChildPath 'release\x32\plugins\x64dbgpy\mona.py')
}

# Adds xAnalyzer support
if (!(Test-Path (Join-Path -Path $destination -ChildPath 'release\x32\plugins\xAnalyzer.dp32'))) {
	$release = '2.5.3'
	$installer = Join-Path -Path $env:temp -ChildPath 'apis_def.zip'
	Invoke-WebRequest -Uri ('https://github.com/ThunderCls/xAnalyzer/releases/download/' + $release + '/apis_def.zip') -OutFile $installer
	if (Test-Path $installer) {
		Expand-Archive $installer -DestinationPath (Join-Path -Path $destination -ChildPath 'release\x32\plugins\apis_def')
	}
	Invoke-WebRequest -Uri ('https://github.com/ThunderCls/xAnalyzer/releases/download/' + $release + '/xAnalyzer.dp32') -OutFile (Join-Path -Path $destination -ChildPath 'release\x32\plugins\xAnalyzer.dp32')
	Invoke-WebRequest -Uri ('https://github.com/ThunderCls/xAnalyzer/releases/download/' + $release + '/xAnalyzer.dp64') -OutFile (Join-Path -Path $destination -ChildPath 'release\x64\plugins\xAnalyzer.dp64')
}

Start-Process (Join-Path -Path $destination -ChildPath 'release\x96dbg.exe')