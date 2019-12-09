Write-Output("                                                                               ")
Write-Output("                                                                               ")
Write-Output("*******************************************************************************")
Write-Output("********              Copy IIS Log From All Regions                    ********")
Write-Output("*******************************************************************************")
Write-Output("                                                                               ")
Write-Output("                                                                               ")
Write-Output("                                                                               ")



#init script 


$BaseOutPutFolder = "LogFiles-" + $(get-date -f MM-dd-yyy-HHmmss) ;
$BasePath = "";


#American Region 

$USServerOneUNCPath  = "\\AMXDHUB01\c$\inetpub\logs\LogFiles\W3SVC1";
$USServerTwoUNCPath  = "\\AMXDHUB02\c$\inetpub\logs\LogFiles\W3SVC1";

#Autralian Region

$AusServerOneUNCPath  = "\\AUDHUB01\c$\inetpub\logs\LogFiles\W3SVC1";
$AusServerTwoUNCPath  = "\\AUDHUB02\c$\inetpub\logs\LogFiles\W3SVC1";


#EAST ASIA Region

$EAServerOneUNCPath  = "\\E-ADHUB01\c$\inetpub\logs\LogFiles\W3SVC1";
$EAServerTwoUNCPath  = "\\E-ADHUB02\c$\inetpub\logs\LogFiles\W3SVC1";


#UK Region

$UKServerOneUNCPath  = "\\GLODHUB01\c$\inetpub\logs\LogFiles\W3SVC1";
$UKServerTwoUNCPath  = "\\GLODHUB02\c$\inetpub\logs\LogFiles\W3SVC1";


#Common Veriables
$BasePath = Get-Location;
$BasePath = Join-Path $BasePath $BaseOutPutFolder;

#Only needed for debugging
#$BasePath = "C:\Projects\Sandpit\Logs\PowershellScripts\LogFiles-09-17-2018-102051\"

$ProcessedEndpointsFolder = "ProcessEndpoints"

#Go back three months 
$backdate = (get-date).AddMonths(-3)

#Creating new parent folder 
New-Item -ItemType Directory -Force -Path $BasePath

Write-Output("                 ** Copying Log files from American Region **                                       ");

 $USRegionTargetOnePath = Join-Path $BasePath "USServerOne"
 $USRegionTargetTwoPath = Join-Path $BasePath "USServerTwo"


 New-Item -ItemType Directory -Force -Path $USRegionTargetOnePath
 New-Item -ItemType Directory -Force -Path $USRegionTargetTwoPath

 Write-Output("US Target folders are created...                                       ");
 
  Write-Output(" Copying files from "+$USServerOneUNCPath)
  
  foreach($item in Get-ChildItem $USServerOneUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
  {
  
     Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

     Copy-Item $item.FullName $USRegionTargetOnePath
 
  }
 
 Write-Output(" Copying files from "+$USServerTwoUNCPath)

 foreach($item in Get-ChildItem $USServerTwoUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $USRegionTargetTwoPath
 
 }

 Write-Output(" finished copying US region files.")
 
 Write-Output("     ")


 Write-Output("                 ** Copying Log files from Australia Region **                                       ");

 $AUSRegionTargetOnePath = Join-Path $BasePath "AUSServerOne"
 $AUSRegionTargetTwoPath = Join-Path $BasePath "AUSServerTwo"



New-Item -ItemType Directory -Force -Path $AUSRegionTargetOnePath
New-Item -ItemType Directory -Force -Path $AUSRegionTargetTwoPath
Write-Output("AUS Target folders are created...                                       ");

 
 Write-Output(" Copying files from "+$AusServerOneUNCPath)
  
 foreach($item in Get-ChildItem $AusServerOneUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $AUSRegionTargetOnePath
 
 }
 

 Write-Output(" Copying files from "+$AusServerTwoUNCPath)

 foreach($item in Get-ChildItem $AusServerTwoUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $AUSRegionTargetTwoPath
 
 }

 Write-Output(" finished copying AUS region files.")
 
 Write-Output("     ")
 
  


  Write-Output("                 ** Copying Log files from East Asia Region **                                       ");

 $EARegionTargetOnePath = Join-Path $BasePath "EAServerOne"
 $EARegionTargetTwoPath = Join-Path $BasePath "EAServerTwo"


 New-Item -ItemType Directory -Force -Path $EARegionTargetOnePath

 New-Item -ItemType Directory -Force -Path $EARegionTargetTwoPath

 Write-Output("EA Target folders are created...                                       ");


 
 Write-Output(" Copying files from "+$EAServerOneUNCPath)
  
 foreach($item in Get-ChildItem $EAServerOneUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $EARegionTargetOnePath
 
 }
 
 Write-Output(" Copying files from "+$EAServerTwoUNCPath)

 foreach($item in Get-ChildItem $EAServerTwoUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $EARegionTargetTwoPath
 
 }

 Write-Output(" finished copying EA region files.")
 
 Write-Output("     ")



  Write-Output("                 ** Copying Log files from UK Region **                                       ");

 $UKRegionTargetOnePath = Join-Path $BasePath "UKServerOne"
 $UKRegionTargetTwoPath = Join-Path $BasePath "UKServerTwo"


 New-Item -ItemType Directory -Force -Path $UKRegionTargetOnePath

 New-Item -ItemType Directory -Force -Path $UKRegionTargetTwoPath

 Write-Output("UK Target folders are created...                                       ");


 
 Write-Output(" Copying files from "+$UKServerOneUNCPath)
  
 foreach($item in Get-ChildItem $UKServerOneUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $UKRegionTargetOnePath
 
 }
 
 Write-Output(" Copying files from "+$UKServerTwoUNCPath)

 foreach($item in Get-ChildItem $UKServerTwoUNCPath -Recurse | Where-Object {  $_.LastWriteTimeUtc -gt $backdate })
 {
  
    Write-Output($item.Name +"   " + $item.LastWriteTimeUtc)

    Copy-Item $item.FullName $UKRegionTargetTwoPath
 
 }

 Write-Output(" finished copying UK region files.")
 
 Write-Output("     ")

 Write-Output("Preparing folders to parse")

$LogFolderList   = New-Object System.Collections.ArrayList
$LogFolderList.AddRange(("USServer", "AUSServer", "EAServer" , "UKServer"))


 foreach($folder in $LogFolderList)  
  {
    Write-Output("Processing "+ $folder)

    $SourceFolderPath = Join-Path $BasePath $folder   
    
    $FolderNamePerRegion = (($folder.ToCharArray() |Select-Object -first 2) -join "").ToUpper()

    $targetPath = join-path $basePath $ProcessedEndpointsFolder

   Invoke-Expression ( './RegionParseLogs.ps1 -LogFolderPath "' + $SourceFolderPath+'" -OutputPath "'+ $targetPath+'" -Region "'+ $FolderNamePerRegion+'"')

   Write-Output($SourceFolderPath)

  }