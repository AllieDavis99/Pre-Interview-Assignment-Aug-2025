<#
Minitab DevOps pre-interview assignment
Parses a txt file and sorts values in a list with 
attributes determined from user input

Inputs: 
    filePath: str
    valueType: str
    sortOrder: str

Outputs: 
    resultList: str
#>

#Valid user inputs
$validTypes = @('alpha','numeric','both')
$validOrders = @('ascending','descending')

#Get user input and check that input is valid
$filePath = Read-Host -Prompt "Enter path to text file"

do{
    $valueType = Read-Host -Prompt "Enter type of value to sort ('alpha', 'numeric', or 'both)"
} until ($validTypes -contains $valueType)

do{
    $sortOrder = Read-Host -Prompt "Enter sort order ('ascending' or 'descending')"
} until ($validOrders -contains $sortOrder)
