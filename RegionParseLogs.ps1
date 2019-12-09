# 
# "*******************************************************************************"
# "********         Parsing UK Region Logs by Each Endpoints              ********"
# "*******************************************************************************"

Param(
    [parameter(Mandatory=$true)]
	[String]$LogFolderPath,
	[parameter(Mandatory=$true)]
    [String]$OutputPath,
    [parameter(Mandatory=$true)]
	[String]$Region) 


$i = 1
$EndPointLists = New-Object System.Collections.ArrayList
$BlockedEndpointList = New-Object System.Collections.ArrayList


$EndPointLists.AddRange(
(   "Offices",
    "Staff",
    "Regions",
    "Groups" ,
    "ClientGroups",
    "ClientMasters",
    "Currencies",
    "CurrentExchangeRates",
    "ExchangeRates",
    "CRMOpportunities", 
    "Projects", 
    "CRMContacts", 
    "CRMOrganisations", 
    "Locations", 
    "Sites",
    "AccountingCentres",
    "Centres",
    "CentreHist", 
    "Companies", 
    "GlobalCentres", 
    "StaffGrades", 
    "Businesses",
    "SubAccountingCentres", 
    "StaffDisciplines", 
    "BidTeamRoles", 
    "SkillsNetworks", 
    "ProjectTeamRoles", 
    "StaffRoles",
    "StaffRoleAssignments", 
    "ArupCountries", 
    "ConcoExchangeRates", 
    "ConcoExchangeRatesFinPeriods", 
    "MissingTimesheets", 
    "RateCards", 
    "RateCardData", 
    "Communities", 
    "Practices", 
    "SubPractices", 
    "TypesOfContent", 
    "Countries", 
    "Topics", 
    "EssentialsSections", 
    "RegionalEssentialsSections", 
    "Jobs", 
    "Themes", 
    "ArupStaffExtended", 
    "ProjectInitialForecasts", 
    "ProjectMonthFinancials", 
    "ProjectFinances", 
    "ProjectOutstandingDebts", 
    "StaffPermissionPools", 
    "StaffProjectPermissionPools", 
    "StaffProjects", 
    "Services", 
    "JobDebts", 
    "ProjectRegionGlobalCentres", 
    "ProjMonthFinCumulatives", 
    "ProjectLastApprovedForecasts", 
    "ArupStaffCostCentreAccesses" 
))

$BlockedEndpointList.AddRange((
"ArupStaffCostCentreAccesses",
"CentreHist",
"ConcoExchangeRates",
"ConcoExchangeRatesFinPeriods",
"CRMOrganisations",
"Currencies",
"CurrentExchangeRates",
"ExchangeRates",
"GlobalCentres",
"JobDebts",
"RateCardData",
"RateCards",
"SubAccountingCentres",
"SubPractices"))


$item = "Staff"
    foreach($item in $EndPointLists)
     {
        if($BlockedEndpointList -notcontains $item ){

            Write-Output("Start parsing endpoint "+ $item)

            $command  = './ParseLogs.ps1 -EndpointName "'+$item+'" -LogFolderPath "'+ $LogFolderPath +'" -OutputPath "'+$OutputPath+'" -Region "'+$Region+'" '
            $message  = "Parsing logs for "+$item+" endpoint, for "+$Region+" region, please wait..."

            Write-Progress -activity $message -status "Parsed : $i of $($EndPointLists.Count)" -percentComplete (($i / $EndPointLists.Count)  * 100)
            Invoke-Expression ($command)

            Write-Output("Finish parsing endpoint "+ $item)
            $i++
        }
        else 
        {
            Write-Output("Skiped parsing, $($item) endpoint is blocked for user access.")
        }
   }

