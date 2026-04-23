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
Add-Type -TypeDefinition $code
[Wallpaper]::SystemParametersInfo(0x0014, 0, $path, 0x01 -bor 0x02)
$shell = New-Object -ComObject Shell.Application
$shell.MinimizeAll()
$title = " 0_0 "
$msg = "   ты за овального ?   "
$result = [System.Windows.Forms.MessageBox]::Show($msg, $title, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
