$teststring  = "UkRegion"


Write-Output((($teststring.ToCharArray() |Select-Object -first 2) -join "").ToUpper())

$str = "Testing/abc/filename.exe"

Write-output($str.Substring($str.LastIndexOf('/')+1 ,$str.Length - ($str.LastIndexOf('/')+1) ))
