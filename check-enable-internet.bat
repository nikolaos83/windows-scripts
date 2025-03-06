# This will check if interface "Wi-Fi" has internet connectivity and reset the interface if there's an issue
# Useful for GPU miners with unreliable wireless interfaces
# Add to scheduled tasks to check for issues periodically

set /a test=0

:InternetTesti
set /a test=%test%+1
powershell -command "invoke-webrequest http://www.msftconnecttest.com/connecttest.txt -outfile '%Temp%\internet.txt'"

dir "%Temp%\internet.txt"

If %errorlevel% EQU 0 (del "%Temp%\internet.txt") & (goto testBitti)
If %test% LSS 3 (timeout 3) & goto InternetTesti

netsh interface set interface "Wi-Fi" disabled
netsh interface set interface "Wi-Fi" enabled

:testBitti
