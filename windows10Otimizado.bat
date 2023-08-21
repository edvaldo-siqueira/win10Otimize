@echo off
echo ** Otimizando o Windows 10 para melhor desempenho e leveza **

:: Definir o plano de energia para Alto Desempenho
echo Configurando o plano de energia para Alto Desempenho...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

:: Aumentar o tamanho do arquivo de paginação
echo Aumentando o tamanho do arquivo de paginação...
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=8192,MaximumSize=16384

:: Desabilitar indexação de arquivos
echo Desabilitando indexação de arquivos...
sc config "WSearch" start=disabled

:: Desabilitar Windows Tips and Tricks
echo Desabilitando dicas e truques do Windows...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: Ajustar prioridade do processador para programas em execução
echo Ajustando prioridade do processador...
wmic cpu where DeviceID="CPU0" call SetPriority 128

:: Reiniciar o serviço de cache de fontes do Windows
echo Reiniciando o serviço de cache de fontes...
net stop FontCache
net start FontCache

:: Reiniciar o serviço de otimização de entrega
echo Reiniciando o serviço de otimização de entrega...
net stop "wuauserv"
net stop "bits"
net stop "dosvc"
net start "wuauserv"
net start "bits"
net start "dosvc"

:: Liberar espaço em disco
echo Limpando arquivos temporários...
del /f /s /q %systemroot%\SoftwareDistribution\Download\*.*
del /f /s /q %systemroot%\Temp\*.*

:: Reiniciar o Explorador do Windows para aplicar as alterações visuais
echo Reiniciando o Explorador do Windows...
taskkill /f /im explorer.exe
start explorer.exe

echo ** Otimizações concluídas. Por favor, reinicie o computador para que as alterações tenham efeito. **
pause
