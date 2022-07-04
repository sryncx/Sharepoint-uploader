<# ############################################################################################################################################################
:-------------------------------------------------------------------:   
: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : :   
:  /-------------------------------------------------------------\  :            
:  : Coder:  Moritz Holzapfel                                    :  :
:  : Email:  moritz.holzapfel@dan.at                             :  :
:  : Purpose: MS - Teams File Upload                             :  :
:  : Date: 15042022                                              :  :
:  : Version: 1.0.0.0                                            :  :
:  \-------------------------------------------------------------/  : 
: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : 
:-------------------------------------------------------------------: 
#> ############################################################################################################################################################

<# ############################################################################################################################################################
                                                Var | Vertreter-Name & Dokument-Name | Date & Time
#> ############################################################################################################################################################
#region Vertreter & Dokumente set Variable
$Vertreter = New-Object PSObject -Property @{
    N1  = "LastNAME1"
    N2  = "LastNAME2"
    N3  = "LastNAME3"
    N4  = "LastNAME4"
    N5  = "LastNAME5"
    N6  = "LastNAME6"
    N7  = "LastNAME7"
    N8  = "LastNAME8"
    N9  = "LastNAME9"
    N10 = "LastNAME10"
    N11 = "LastNAME11"
    N12 = "LastNAME12"

    N96 = "LastNAME13"
    N97 = "LastNAME14"
    N98 = "LastNAME15"
    N99 = "LastNAME16"

    Team = "M$-Team Comp Name"
 
    V1  = "FirstNAME1"
    V2  = "FirstNAME2"
    V3  = "FirstNAME3"
    V4  = "FirstNAME4"
    V5  = "FirstNAME5"
    V6  = "FirstNAME6"
    V7  = "FirstNAME7"
    V8  = "FirstNAME8"
    V9  = "FirstNAME9"
    V10 = "FirstNAME10"
    V11 = "FirstNAME11"
    V12 = "FirstNAME12"

    V96 = "FirstNAME13"
    V97 = "FirstNAME14"
    V98 = "FirstNAME15"
    V99 = "FirstNAME16"
}

$Dokument = New-Object PSObject -Property @{
    D1  = "M7*.pdf"
    D2  = "M3.2*.pdf"
    PDF = "*.pdf"
}
#endregion

#region Date&Time set Variable
$Date = (Get-Date).ToString(„dd.MM.yyyy“)
$Time = (Get-Date).ToString(„hh:mm:ss“)
#endregion

<# ############################################################################################################################################################
                                                Funktion to genera LogFile on "\\UNC-SERVER-Path\Folder\Folder\Folder\Log"
#> ############################################################################################################################################################

#region LOGFUNCTION
#region Vars for Log
$path = "\\UNC-SERVER-Path\Folder\Folder\Folder\Log"
$date = get-date -format "yyyy-MM-dd-HH-mm"
$file = ("DAN_TEAMS_UPLOAD" + $date + ".log")
$logfile = $path + "\" + $file
#endregion Vars for Log

#region Write Log File
function Write-Log([string]$logtext, [int]$level = 0) {
    $logdate = get-date -format "yyyy-MM-dd HH:mm:ss"
    if ($level -eq 0) {
        $logtext = "[INFO] " + $logtext
        $text = "[" + $logdate + "] - " + $logtext
        Write-Host $text
    }
    if ($level -eq 1) {
        $logtext = "[WARNING] " + $logtext
        $text = "[" + $logdate + "] - " + $logtext
        Write-Host $text -ForegroundColor DarkYellow
    }
    if ($level -eq 2) {
        $logtext = "[ERROR] " + $logtext
        $text = "[" + $logdate + "] - " + $logtext
        Write-Host $text -ForegroundColor Red
    }
    $text >> $logfile
}
#endregion Write Log File
#endregion LOGFUNCTION

<# ############################################################################################################################################################
                                                Uploader Bar Funktion
#> ############################################################################################################################################################

function UploaderBar-func{
  param(
	[string]$UpBar1,
	[int]$UpBar2,
	[string]$UpBar3
  )
"[$UpBar1]" | Out-File -FilePath C:\uploader\BAR.ini
"Bar=$UpBar2" | Out-File -FilePath C:\uploader\BAR.ini -Append
"TXT=$UpBar3" | Out-File -FilePath C:\uploader\BAR.ini -Append
}

<# ############################################################################################################################################################
                                                Funktion for Upload Files 2 Shaerpoint
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 5 "Load Funktions"
#region Upload - Filesharepoint Function
function UPLOAD-FILE2SHAREPOINT{

#region String Var
param(
     [string]$site_objectid,
     [string]$filterfilename,
     [string]$filename,
     [string]$filepath,
     [string]$year,
     [string]$kw,
     [string]$accesstoken,
     [int]$vorgesetzer
     )

     $accesstoken = $tokenResponse.access_token

    $headers = @{
                "Authorization" = "Bearer $accesstoken"
                "Content-Type"  = "application/json"
                }
#endregion String Var

#region set vars 2 null
    $AllChannelsURL = $null
    $AllChannels =    $null
    $AllChannelsvalue = $null
    $channel = $null
    $ChannelFolderURL = $null
    $ChannelFolder = $null
    $DriveID = $null
    $destination = $null
    $Content = $null
    $uploadresult = $null
#endregion set vars 2 null

#region Write Log
    Write-Log "Start Uploading File $($filepath)"
#endregion Write Log

#region Get Destination in Sharepoint
    $i = 0
    $AllChannelsURL = "https://graph.microsoft.com/v1.0/teams/$($site_objectid)/channels"  
    Write-host "$($AllChannelsURL)"
    try {
        while(($AllChannels.'@odata.count') -lt 1)
        {
        try {
           $AllChannels = Invoke-RestMethod -Headers $headers -Uri $AllChannelsURL -Method GET -ErrorAction Stop
           Write-host "try $i"
           $i++
           }
        catch{Write-Host "Error get channel $_"
        }
        }
        
start-sleep 2


    $AllChannelsvalue = $($AllChannels.value)
    if(!$AllChannelsvalue) 
    {throw "Channel Value is empty"}
    Write-host "All channels: $($AllChannelsvalue.count)"
    $channel =  $AllChannelsvalue | Where-Object { $_.DisplayName -like "$($filterfilename)*"}
    
     if($($channel.count) -gt 1)
     {
     Throw "More then 1 Channel was detected the Script will be terminated"
     }

    <#
    if($($channel.count) -gt 1) {

        $channel = $channel | Where-Object {$_.id -eq '19:4aa5d0ada0984868b603831b21fb0730@thread.tacv2'} #;) wyld
        
        }
    #>

        Write-host "Channeldpname :$($channel.displayname)"
    $ChannelFolderURL = "https://graph.microsoft.com/beta/teams/$site_objectid/channels/$($channel.id)/filesFolder"  
    $ChannelFolder = Invoke-RestMethod -Headers $headers -Uri $ChannelFolderURL -Method GET
        Write-host "Get Channel Folder was Successfull : $ChannelFolder"
    $DriveID = ($ChannelFolder.parentReference).driveId
        Write-host "Drive ID fuer den Channel $($Channel.displayName) wurde generiert: DriveID : $($DriveID)"
    }
    catch {
            Write-Log "Error generating Drive ID for Channel: Errormessage : $_" 2
            Write-Log "Der Uploadvorgang fuer $($filepath) wird nun beendet"
            $errormessage = "Error generating Drive ID for Channel: Errormessage : $_"
            $fail = 1
            return
            }
    
$destination = ""

    if([int]$vorgesetzer -eq 1) {
        $destination = "https://graph.microsoft.com/v1.0/drives/$DriveID/root:/$($channel.displayName)/Folder/Folder/$year/$Month/ADM/$($Filename):/content"
        }
    elseif([int]$vorgesetzter -eq 2) {
        $destination = "https://graph.microsoft.com/v1.0/drives/$DriveID/root:/$($channel.displayName)/Folder/Folder/$year/$Month/$($Filename):/content"
        }
    else {
        $destination = "https://graph.microsoft.com/v1.0/drives/$DriveID/root:/$($channel.displayName)/folder/Folder/$year/$Month/$($Filename):/content"
        }

    Write-Log "Das File wird nun hochgeladen"
    Write-Log "Destinationpath URL : $($destination)"
    
    try {
        $Content=[IO.File]::ReadAllBytes($Filepath)
    }
    catch {
        Write-Log "Error get Content: Errormessage : $_" 2
        Write-Log "Der Uploadvorgang fuer $($filepath) wird nun beendet"
        $errormessage = "Error get Content: Errormessage : $_"
        $fail = 1
        return
    }

    if ($Content.Length -gt 1) {
            $upload_headers = @{
            "Authorization" = "Bearer $($tokenResponse.access_token)"      
            }
    
        try {   
           $uploadresult = Invoke-RestMethod -Headers $upload_headers -Uri $destination  -Method Put -Body $content -ContentType "application/pdf" -ErrorAction Stop
           }

        catch {
            Write-Log "Error Uploading File with Invoke-Restmethod: Errormessage : $_" 2
            Write-Log "Der Uploadvorgang fuer $($filepath) wird nun beendet"
            $errormessage = "Error Uploading File with Invoke-Restmethod: Errormessage : $_"
            $fail = 1
            return
        }
    
    }
    else {
        Write-Log "Kein Content fuer den Upload vorhanden, Upload wurde nicht druchgefuehrt" 2   
    }

    if ($uploadresult) {
        Write-Log "Upload wurde erfolgreich durchgefuehrt"
        Write-Log "Filename : $($uploadresult.name)"
        Write-Log "File ID : $($uploadresult.id)"
        Write-Log "Created : $($uploadresult.createdDateTime)"
        Write-Log "File URL : $($uploadresult.webUrl)"
        }

if($fail -eq 1){
    return $errormessage
    }
if($uploadresult){
    return $uploadresult
    }
}
#endregion Get Destination in Sharepoint

#region Write Log
    Write-Log "Start Script"
#endregion Write Log
#endregion Upload - Filesharepoint Function

<# ############################################################################################################################################################
                                                InI read out data from file
#> ############################################################################################################################################################

function Get-IniFile 
{  
    param(  
        [parameter(Mandatory = $true)] [string] $filePath  
    )  
    
    $anonymous = "NoSection"
  
    $ini = @{}  
    switch -regex -file $filePath  
    {  
        "^\[(.+)\]$" # Section  
        {  
            $section = $matches[1]  
            $ini[$section] = @{}  
            $CommentCount = 0  
        }  

        "^(;.*)$" # Comment  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  
        }   

        "(.+?)\s*=\s*(.*)" # Key  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  
        }  
    }  

    return $ini  
}  

$iniFile = Get-IniFile "C:\uploader\uploader.ini"

<# ############################################################################################################################################################
                                              Vars from Gui & Siteobject ID
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 10 "Generate Site Object ID"
#region Vars from Gui & Siteobject ID
[string]$Year = $iniFile.Uploader_Statistik.Year
[string]$Month = $iniFile.Uploader_Statistik.Month
    $site_objectid = "ObjectID" #Object ID of the TEAMS Group from Azure
    $fail = $false
#endregion Vars from Gui & Siteobject ID

<# ############################################################################################################################################################
                                              Generate Access Token to get handshake with Sharepoint over GraphApi
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 15 "Generate Access Token"
#region generate access token
    $clientId = "Client-ID"
    $clientSecret = "-Client-Secret-ID"
    $tenantName = "Tenant-ID"
    $resource = "https://graph.microsoft.com/"

    $tokenBody = @{
        Grant_Type    = 'client_credentials'  
        Scope         = 'https://graph.microsoft.com/.default'  
        Client_Id     = $clientId  
        Client_Secret = $clientSecret
        }
        try {
            Write-Log "Retrive access Token"
            $tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $tokenBody -ErrorAction Stop
            Write-Log "Token was successfully generated"
            }
        catch {
            Write-Log "Error generating access token: Errormessage: $_" 2
            Write-Log "Das Script wird nun beendet"
            $fail = $true
            return
            }

    $headers = @{
        "Authorization" = "Bearer $($tokenResponse.access_token)"
        "Content-Type"  = "application/json"
        }
#endregion generate access token

<# ############################################################################################################################################################
                                               Upload User.PDF - To User
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 20 "Upload AD-Files to AD-User"
#region loop for user to upload $User . PDF
$I = 1
While ($I -le 12) {
    $Name = $Vertreter."N$I"
    $GL = $Vertreter."N$I" + " " + $Vertreter."V$I"
    $sourceprefix = "\\UNC-SERVER-Path\Folder\Folder\Folder\$Month\$Name\"
    $sourcepaths = "$sourceprefix$GL$($Dokument.PDF)"

#region get Items to Upload
$uploaditems = @()
foreach($src in $sourcepaths) {
    $uploaditems += Get-Item -Path $src | Where-Object {$_.Extension -eq '.pdf'} | Select-Object *
    }
#endregion get Items to Upload

#region Destination to Upload
$file = $null #define Var File as 0
foreach($file in $uploaditems) {
    $filepath = $($file.FullName) #source Filepath for Upload
    $filename = $($file.PSChildName)
    [string]$filterfilename = $GL
    UPLOAD-FILE2SHAREPOINT -site_objectid $site_objectid -filterfilename "$filterfilename" -filepath "$filepath" -filename "$filename" -year $year -kw $Monat -accesstoken "$($tokenResponse.access_token)"
    }
    $I++ #count Var "I" +1
}
#endregion Destination to Upload
#endregion loop for user to upload $User . PDF

<# ############################################################################################################################################################
                                               Upload M7 & M3.2 .PDF - To User
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 40 "Upload File M7 & M3.2 to AD-User"
#region loop for user to upload dokuments M7 . PDF
$I = 1
While ($I -le 12) {
    $Name = $Vertreter."N$I"
    $GL = $Vertreter."N$I" + " " + $Vertreter."V$I"
    $sourceprefix = "\\UNC-SERVER-Path\Folder\Folder\Folder\$Month\"
    $sourcepaths = @(
        "$sourceprefix$($Dokument.D1)",
        "$sourceprefix$($Dokument.D2)"
        )


#region get Items to Upload
$uploaditems = @()
foreach($src in $sourcepaths) {
    $uploaditems += Get-Item -Path $src | Where-Object {$_.Extension -eq '.pdf'} | Select-Object *
    }
#endregion get Items to Upload

#region Destination to Upload
$file = $null #define Var File as 0
foreach($file in $uploaditems) {
    $filepath = $($file.FullName) #source Filepath for Upload
    $filename = $($file.PSChildName)
    [string]$filterfilename = $GL
    UPLOAD-FILE2SHAREPOINT -site_objectid $site_objectid -filterfilename "$filterfilename" -filepath "$filepath" -filename "$filename" -year $year -kw $Monat -accesstoken "$($tokenResponse.access_token)"
    }
    $I++ #count Var "I" +1
}
#endregion Destination to Upload
#endregion loop for user to upload dokuments M7 . PDF

<# ############################################################################################################################################################
                                               Generate Massage from P$ to M$-Team
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 90 "Send Status MSG to MS-Teams"
#region Generate Webhook Object
$JSONBody = [PSCustomObject][Ordered]@{
    "summary"    = "P$ data"
    "themeColor" = '0000ff'
    "title"      = "Monat Statistik Upload abgeschlossen."
    "text"       = "Monat: $Month
                    Datum: $Date
                    Zeit: $Time"
     }
    
    $TeamMessageBody = ConvertTo-Json $JSONBody -Depth 100
    $parameters = @{
        "URI"         = 'URL-M$-Teams'
        "Method"      = 'POST'
        "Body"        = $TeamMessageBody
        "ContentType" = 'application/json'
        }
    Invoke-RestMethod @parameters
#endregion Generate Webhook Object

<# ############################################################################################################################################################
                                               Generate Massage per Mail
#> ############################################################################################################################################################
UploaderBar-func "Uploader" 95 "Send Status Mail to AD"
#region Generate Mail with SMTP adress
[String]$From = "Mail-sender-Adress"
[String]$Smtp = "Smtp-Adress"
[string]$Subject = "Monats Statistik"
[string]$Body = "Monats Statistik $Month $Year wurde in MS-Teams zu verfügung gestellt."

<#
$LC = 1
While ($LC -le 1) {
    $To = "$($Vertreter."V$LC").$($Vertreter."N$LC")@domain.xyz"
    send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer $Smtp
        $LC++
    }
#endregion Generate Mail with SMTP adress
#>
UploaderBar-func "Uploader" 100 "End Upload"
Timeout /T 5
UploaderBar-func "Uploader" 100 "LoaderBarGuiDestroy"