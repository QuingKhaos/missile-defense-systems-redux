Set-Variable -Name workspace -Value $Env:FACTORIO_WORKSPACE
Set-Variable -Name mod_base -Value $Env:FACTORIO_21_MODS_BASE
Set-Variable -Name package -Value "###NAME###"

New-Item -ItemType Directory -Force -Path "$mod_base" | Out-Null
Copy-Item -Force -Recurse -Path "$workspace\$package\.dev\mods2.1\*" -Destination "$mod_base" -ErrorAction SilentlyContinue

Set-Variable -Name version -Value (Get-Content "$workspace\$package\info.json" | ConvertFrom-Json).version
Move-Item -Path "$workspace\$package\${package}_${version}.zip" -Destination "$mod_base" -Force -ErrorAction SilentlyContinue

Set-Variable -Name version_khaosbash -Value (Get-Content "$workspace\khaosbash\info.json" | ConvertFrom-Json).version
Move-Item -Path "$workspace\khaosbash\khaosbash_$version_khaosbash.zip" -Destination "$mod_base" -Force -ErrorAction SilentlyContinue

Set-Variable -Name version_khaoslib -Value (Get-Content "$workspace\khaoslib\info.json" | ConvertFrom-Json).version
Move-Item -Path "$workspace\khaoslib\khaoslib_$version_khaoslib.zip" -Destination "$mod_base" -Force -ErrorAction SilentlyContinue

Start-Process -FilePath "${Env:FACTORIO_21_PATH}\bin\x64\Factorio.exe" -ArgumentList "--mod-directory $mod_base"
