$str = 'start end'
$str = $str -replace ' ','_'
$str




$distGroups = Get-DistributionGroup -ResultSize Unlimited

ForEach ($group in $distGroups) {
    $str=$group.Alias
    If ($str.contains(" ")) {
        
        write-output $str
        $str = $str -replace ' ','_'
        $str
        Set-DistributionGroup $group -Alias $str -Confirm:$false -Force
        get-DistributionGroup $group | fl Alias 
    }

}


