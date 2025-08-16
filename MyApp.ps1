<#
Minitab DevOps pre-interview assignment
Parses a txt file and sorts values in a list with 
attributes determined from user input

Inputs: 
    filePath: str
    valueType: str
    sortOrder: str

Outputs: 
    resultArray: str
#>

#Valid user inputs
$validTypes = @('alpha','numeric','both')
$validOrders = @('ascending','descending')

#Get user input and check that input is valid
do {
    $filePath = Read-Host -Prompt "Enter path to text file"
} until (Test-Path -Path $filePath)

do{
    $valueType = Read-Host -Prompt "Enter type of value to sort ('alpha', 'numeric', or 'both)"
} until ($validTypes -contains $valueType)

do{
    $sortOrder = Read-Host -Prompt "Enter sort order ('ascending' or 'descending')"
} until ($validOrders -contains $sortOrder)

#Start actually parsing text
$rawText = Get-Content -Path $filePath
$textArray = $rawText -split ",\s*"
$resultArray = @()

function Sort-Numeric {
    <#
    Outputs numeric values from $textArray in ascending or descending order
    depending on the user input
    #>

    #Adds each item that can be converted into a double to the result array 
    foreach ($item in $textArray){
        if ($item -as [double]){
            $script:resultArray += [double]$item
        }
    }

    #Then sort
    if ($sortOrder -eq "ascending"){
        $script:resultArray = $resultArray | Sort-Object 
    }
    else{
        $script:resultArray = $resultArray | Sort-Object -Descending
    }
}

function Sort-Alpha{
    <#
    Outputs non-numeric values from $textArray in ascending or descending order
    depending on the user input
    #>

    #Adds each item that can NOT be converted into a double to the result array
    foreach ($item in $textArray){
        if ($null -eq ($item -as [double])){
            $script:resultArray += $item
        }
    }

    #Then sort
    if ($sortOrder -eq "ascending"){
        $script:resultArray = $resultArray | Sort-Object 
    }
    else{
        $script:resultArray = $resultArray | Sort-Object -Descending
    }
}

function Sort-Both{
    <#
    Outputs all values from $textArray in ascending or descending order
    depending on the user input
    #>

    #Adds all items to result array, converting numeric values if needed
    foreach($item in $textArray){
        if($item -as [double]){
            $script:resultArray += [double]$item
        }
        else{
            $script:resultArray += $item
        }
    }

    #Then sort
    if ($sortOrder -eq "ascending"){
        $script:resultArray = $resultArray | Sort-Object 
    }
    else{
        $script:resultArray = $resultArray | Sort-Object -Descending
    }
}


#Call the appropriate sorting function
if ($valueType -eq 'numeric'){
    Sort-Numeric
}
elseif ($valueType -eq 'alpha'){
    Sort-Alpha
}
else{
    Sort-Both
}

#Print sorted array to the terminal
Write-Host $resultArray
