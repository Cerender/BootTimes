<#------------------------------------------------------------------------------
    Jason McClary
    mcclarj@mail.amc.edu
    28 Mar 2016
    
    Description:
    Gather Server boot time into a CSV
    
    Arguments:
    If blank script runs against local computer
    Multiple computer names can be passed as a list separated by spaces:
        ServerBootTimes.ps1 computer1 computer2 anotherComputer
    A text file with a list of computer names can also be passed
        ServerBootTimes.ps1 comp.txt
        
    Tasks:
    - Create a file that lists last boot up time

        
--------------------------------------------------------------------------------
                                CONSTANTS
------------------------------------------------------------------------------#>
#Date/ Time Stamp
$dtStamp = $(Get-Date -UFormat "%Y%b%d") + "_" + $(Get-Date -UFormat "%H") + "-" + $(Get-Date -UFormat "%M")

set-variable logOutput -option Constant -value "BootTimes_$dtStamp.txt"

<#------------------------------------------------------------------------------
                                FUNCTIONS
------------------------------------------------------------------------------#>

    
<#------------------------------------------------------------------------------
                                    MAIN
------------------------------------------------------------------------------#>

## Format arguments from none, list or text file 
IF (!$args){
    $compNames = $env:computername # Get the local computer name
} ELSE {
    $passFile = Test-Path $args

    IF ($passFile -eq $True) {
        $compNames = get-content $args
    } ELSE {
        $compNames = $args
    }
}

# To screen
Get-WmiObject -ComputerName $compNames win32_operatingsystem | select @{LABEL='Computer Name';EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

#To file
Get-WmiObject -ComputerName $compNames win32_operatingsystem | select @{LABEL='Computer Name';EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}} | Out-file -filepath $logOutput -Encoding utf8