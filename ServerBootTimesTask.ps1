<#------------------------------------------------------------------------------
    Jason McClary
    mcclarj@mail.amc.edu
    13 Jun 2016
    06 Jul 2016 - Modified for task scheduler

    
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

set-variable logOutput -option Constant -value "C:\Users\mcclarj\Desktop\Server_Info\BootTimes_$dtStamp.txt"

<#------------------------------------------------------------------------------
                                FUNCTIONS
------------------------------------------------------------------------------#>

    
<#------------------------------------------------------------------------------
                                    MAIN
------------------------------------------------------------------------------#>

$compNames = get-content "C:\Users\mcclarj\Desktop\Server_Info\EDM_Servers.txt"


#To file
Get-WmiObject -ComputerName $compNames win32_operatingsystem | select @{LABEL='Computer Name';EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}} | Out-file -filepath $logOutput -Encoding utf8