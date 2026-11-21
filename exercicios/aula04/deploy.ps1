<#
  deploy.ps1 - Aula 04 (bonus): build, instala, abre, tira print e mostra o logcat.
  Uso (dentro da pasta do projeto Flutter):
      powershell -ExecutionPolicy Bypass -File deploy.ps1
  Opcoes:
      -Projeto C:\caminho\do\app   pasta do projeto Flutter (padrao: pasta atual)
      -LogcatSegundos 10           mostra o log do app por N segundos e sai
                                   (0 = acompanha ao vivo ate Ctrl+C)
#>
param(
    [string]$Projeto = (Get-Location).Path,
    [int]$LogcatSegundos = 0
)

# ---- configuracao ---------------------------------------------------------
$AppId = 'br.edu.unit.anatomia_app'      # application ID do app
# --------------------------------------------------------------------------

# Equivalente ao "set -e": erro do PowerShell interrompe o script, e
# cada comando nativo (adb, flutter) e checado pelo $LASTEXITCODE em Rodar.
$ErrorActionPreference = 'Stop'

$Prints = Join-Path $PSScriptRoot 'prints'
$Apk    = Join-Path $Projeto 'build\app\outputs\flutter-apk\app-debug.apk'
$etapa  = 0

function Titulo([string]$msg) {
    $script:etapa++
    Write-Output ''
    Write-Output ("[{0}/7] {1}" -f $script:etapa, $msg)
}

function Falhar([string]$msg) {
    Write-Output ''
    Write-Output "ERRO: $msg"
    exit 1
}

# Roda um comando nativo, mostra a saida e aborta se ele falhar.
function Rodar([scriptblock]$cmd, [string]$seFalhar, [switch]$PodeFalhar) {
    $ErrorActionPreference = 'Continue'   # stderr de nativo nao e erro fatal
    & $cmd 2>&1 | ForEach-Object { "    $_" }
    $code = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    if ($code -ne 0 -and -not $PodeFalhar) { Falhar "$seFalhar (codigo $code)" }
    return
}

Write-Output "== deploy de $AppId =="
Write-Output "Projeto: $Projeto"

# 1. aparelho conectado?
Titulo 'Verificando aparelho conectado'
if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    Falhar 'adb nao encontrado no PATH (veja platform-tools do Android SDK).'
}
$linhas = (& adb devices) -split "`r?`n" | Where-Object { $_ -match "`tdevice$" }
if (-not $linhas) {
    Falhar 'Nenhum aparelho conectado. Ligue o cabo (ou adb connect) e autorize a depuracao.'
}
if (@($linhas).Count -gt 1) {
    Write-Output '    Mais de um aparelho encontrado; usando o primeiro.'
}
$Serial = ((@($linhas)[0]) -split "`t")[0]
$env:ANDROID_SERIAL = $Serial              # adb passa a usar so este aparelho
$Modelo = (& adb shell getprop ro.product.model).Trim()
Write-Output "    OK: $Serial ($Modelo)"

# 2. build
Titulo 'flutter build apk --debug'
if (-not (Test-Path (Join-Path $Projeto 'pubspec.yaml'))) {
    Falhar "Nao achei pubspec.yaml em $Projeto"
}
Push-Location $Projeto
try {
    Rodar { flutter build apk --debug } 'O build falhou'
} finally { Pop-Location }
if (-not (Test-Path $Apk)) { Falhar "APK nao encontrado em $Apk" }
Write-Output ("    APK: {0:N1} MB" -f ((Get-Item $Apk).Length / 1MB))

# 3. desinstala a versao anterior (sem falhar se nao existir)
Titulo 'Desinstalando versao anterior'
$instalado = & adb shell pm list packages $AppId | Where-Object { $_ -eq "package:$AppId" }
if ($instalado) {
    Rodar { adb uninstall $AppId } 'Falha ao desinstalar' -PodeFalhar
} else {
    Write-Output '    App nao estava instalado; nada a remover.'
}

# 4. instala
Titulo 'Instalando o APK novo'
Rodar { adb install $Apk } 'Falha na instalacao'

# 5. abre
Titulo 'Abrindo o app'
Rodar { adb shell monkey -p $AppId -c android.intent.category.LAUNCHER 1 } 'Nao consegui abrir o app'
Start-Sleep -Seconds 4                    # tempo para o primeiro frame aparecer

# 6. print
Titulo 'Capturando print'
New-Item -ItemType Directory -Force -Path $Prints | Out-Null
$png = Join-Path $Prints ("deploy-{0}.png" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
# cmd /c porque o ">" do PowerShell corromperia o PNG (vide B3)
cmd /c "adb exec-out screencap -p > `"$png`""
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $png) -or (Get-Item $png).Length -eq 0) {
    Falhar 'Falha ao capturar o print'
}
Write-Output ("    Salvo: {0} ({1:N0} bytes)" -f $png, (Get-Item $png).Length)

# 7. logcat filtrado pelo processo do app
Titulo 'Logcat do app'
$appPid = (& adb shell pidof $AppId | Out-String).Trim()
if (-not $appPid) { Falhar 'O app nao esta rodando (pidof vazio).' }
Write-Output "    PID do app: $appPid"
if ($LogcatSegundos -gt 0) {
    Start-Sleep -Seconds $LogcatSegundos
    Rodar { adb logcat -d --pid=$appPid } 'Falha ao ler o logcat'
    Write-Output ''
    Write-Output "== deploy concluido com sucesso =="
} else {
    Write-Output '    Acompanhando ao vivo. Ctrl+C para sair.'
    Write-Output "== deploy concluido com sucesso =="
    & adb logcat --pid=$appPid
}
