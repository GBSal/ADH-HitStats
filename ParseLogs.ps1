
Param(
    [parameter(Mandatory=$false)]
    [Bool]$AutoOpen,
	[parameter(Mandatory=$false)]
    [String]$OutFile,
	[parameter(Mandatory=$false)]
    [Bool]$IgnoreInParams,
	[parameter(Mandatory=$false)]
	[Bool]$IgnoreOutParams,
	[parameter(Mandatory=$true)]
	[String]$EndpointName,
	[parameter(Mandatory=$true)]
	[String]$LogFolderPath,
	[parameter(Mandatory=$true)]
	[String]$OutputPath, 
	[parameter(Mandatory=$true)]
	[String]$Region) 
	
	
$Error.Clear()
$DefaultFolder=[Environment]::GetFolderPath("MyDocuments")

if($OutputPath -ne [String]::Empty){
	$DefaultFolder  = $OutputPath
}



$Destination =   $Region+"-"+$EndpointName+ ".CSV"
$Destination = $DefaultFolder + "\" + $Destination

if($OutFile -ne [String]::Empty)
{
	$OutFileType = [System.IO.Path]::GetExtension($OutFile.ToUpper())
	$OriginalFileType = [System.IO.Path]::GetExtension($Destination.ToUpper())
	if($OutFileType -ne $OriginalFileType)
	{
		Write-Host "You have chosen" $OutFileType "as the output, but this script was originally generated as" $OriginalFileType -ForegroundColor Red
		Write-Host "Either change -OutFile to" $OriginalFileType "or generate the script again with the output as" $OutFileType  -ForegroundColor Red
		Write-Host "You can also modify the OutputFormat variable in this script to match the correct Log Parser 2.2 COM output format." -ForegroundColor Red
		[System.Environment]::NewLine
		return
	}
	else
	{
		if($true -ne $OutFile.Contains("\"))
		{
		  $Destination = $DefaultFolder + "\" + $OutFile
		}
		else
		{
		  $Destination = $OutFile
		}
	}
}

$LogQuery = New-Object -ComObject "MSUtil.LogQuery"
$InputFormat = New-Object -ComObject "MSUtil.LogQuery.IISW3CInputFormat"
$OutputFormat = New-Object -ComObject "MSUtil.LogQuery.CSVOutputFormat"

if($IgnoreInParams-eq $false){
     $InputFormat.iCodePage=0
     $InputFormat.recurse=-1
     $InputFormat.minDateMod="1900-01-01 12:00:00"
     $InputFormat.dirTime=0
     $InputFormat.consolidateLogs=1
     $InputFormat.useDirectiveDateTime=0
     $InputFormat.useDoubleQuotes=0
}

if($IgnoreOutParams -eq $false){
     $OutputFormat.Headers="AUTO"
     $OutputFormat.oDQuotes="AUTO"
     $OutputFormat.tabs=0
     $OutputFormat.oTsFormat="yyyy-MM-dd hh:mm:ss"
     $OutputFormat.oCodepage=0
     $OutputFormat.fileMode=1
}
#Write-Progress -Activity "Executing query, please wait..."  -Status " "

$SQLQuery = "SELECT cs-uri-stem, cs-username, count(cs-username) as hitscount ,'"+$EndpointName +"' as endpoint,'"+$Region+"' as region, c-ip as ip, date as datetime  INTO '" + $Destination + "' FROM  '"+ $LogFolderPath + "One\*.log , " +$LogFolderPath+"Two\*.log'   WHERE sc-status = 200 AND ( cs-uri-stem like '%"+$EndpointName+"%' or cs-uri-query like '%"+$EndpointName+"%') AND cs-username IS NOT NULL GROUP BY cs-uri-stem, cs-username , ip, datetime"
Write-Output($SQLQuery)
$rtnVal = $LogQuery.ExecuteBatch($SQLQuery, $InputFormat, $OutputFormat);
$OutputFormat = $null;
$InputFormat = $null;
$LogQuery = $null;

if($AutoOpen)
{
	try
	{
		Start-Process($Destination)
	}
	catch
	{
		Write-Host $_.Exception.Message  -ForegroundColor Red
		Write-Host $_.Exception.GetType().FullName  -ForegroundColor Red
		Write-Host "NOTE: No output file will be created if the query returned zero records!"  -ForegroundColor Gray
	}	
}