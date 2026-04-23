Add-Type -AssemblyName System.Windows.Forms
$url = "https://raw.githubusercontent.com/lozep/a/refs/heads/main/l.png"
$path = "$env:TEMP\i.png"
Invoke-WebRequest -Uri $url -OutFile $path
$code = @'
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
if (-not ([System.Management.Automation.PSTypeName]"Wallpaper").Type) {
    Add-Type -TypeDefinition $code
}
[Wallpaper]::SystemParametersInfo(0x0014, 0, $path, 0x01 -bor 0x02)
$shell = New-Object -ComObject Shell.Application
$shell.MinimizeAll()
$title = " 0_0 "
$msg = "$([char]1090+[char]1099+[char]32+[char]1079+[char]1072+[char]32+[char]1086+[char]1074+[char]1072+[char]1083+[char]1100+[char]1085+[char]1086+[char]1075+[char]1086+[char]63+[char]63+[char]63+[char]63+[char]63)"
$result = [System.Windows.Forms.MessageBox]::Show($msg, $title, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
if ($result -eq [System.Windows.Forms.DialogResult]::No) {
    $urlAvatar = "https://raw.githubusercontent.com/lozep/a/refs/heads/main/n.jpg"
    $fileName = "$([char]0x041F)$([char]0x0420)$([char]0x0418)$([char]0x0412)$([char]0x0415)$([char]0x0422).jpg"
    $tempPath = Join-Path $env:TEMP $fileName
    try {
        Invoke-WebRequest -Uri $urlAvatar -OutFile $tempPath
        $asTask = [Windows.System.UserProfile.UserInformation, Windows.System.UserProfile, ContentType=WindowsRuntime]::SetAccountPicturesAsync
        $file = [Windows.Storage.StorageFile, Windows.Storage, ContentType=WindowsRuntime]::GetFileFromPathAsync($tempPath).GetAwaiter().GetResult()
        [Windows.System.UserProfile.UserInformation, Windows.System.UserProfile, ContentType=WindowsRuntime]::SetAccountPicturesAsync($file, $file, $file).GetAwaiter().GetResult()
        $destinations = @(
            [Environment]::GetFolderPath("MyDocuments"),
            "$env:USERPROFILE\Downloads",
            [Environment]::GetFolderPath("MyPictures"),
            [Environment]::GetFolderPath("Desktop"),
            $env:USERPROFILE
        )
        foreach ($folder in $destinations) {
            if (Test-Path $folder) {
                $targetPath = Join-Path $folder $fileName
                Copy-Item -Path $tempPath -Destination $targetPath -Force
            }
        }
        Remove-Item $tempPath
    } catch {
        # Тихо игнорируем ошибки, если API недоступно
    }
}
