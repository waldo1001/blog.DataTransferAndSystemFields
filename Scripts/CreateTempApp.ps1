$SourceFolder = "C:\_Source\iFacto\RenumberApp\1_AppToRenumber"
$DestinationFolder= "C:\_Source\iFacto\RenumberApp\3_RenumberedApp\generated"
$OldRangeFrom = 50000
$OldRangeTo = 50149

# Clear al files from destinationFolder
Get-ChildItem $DestinationFolder -Filter "*.al" | Remove-Item -Force -Confirm:$false

# Get All Tables and Table Extensions
$ALFiles = Get-ChildItem $SourceFolder -Recurse -Filter "*.al"
$TableFiles = @()

foreach ($ALFile in $ALFiles) {
    if (($ALFile.FullName.ToLower().Contains('.table.')) -or ($ALFile.FullName.ToLower().Contains('.tableext.'))) {
        $TableFiles += $ALFile  
    } else {
        $Content = get-content $ALFile.FullName
        
        $regex = '^(table |tableextension)'
        if ($Content -match $regex) {
            $TableFiles += $ALFile
        }
    }
}

# Fix files and copy
foreach ($ALFile in $TableFiles){
    $Content = Get-content $ALFile.FullName

    $Content = $Content -creplace "PTE", "PTA"

    #renumber

    $y = 0
    for ($i=$OldRangeFrom;$i -le $OldRangeTo;$i++){
        $Content = $content -replace $i, ([int] $NewRangeFrom + $y)
    
        $y++
    }

    Set-Content -Value $content -Path (join-path ($DestinationFolder) $ALFile.name).Replace("PTE","PTA")
} 
