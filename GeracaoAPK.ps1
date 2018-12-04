#Ler Kestore do diretorio atual
function Get-Chave {
    $files = ls
    $chave = $files -match '.*\.keystore'
    return $chave
}

#HasTable
$caminho = @{
    Aplicacao = (Get-Location).Path;
    jdk = "C:\Program Files\java\jdk1.8.0_172\bin"
}
$arquivo = @{
    log = "log.txt";
    apk = "lojasrede.apk";
    chave = Get-Chave
}
$comando = @{
    build = "quasar build -m cordova -T android";
    assinar = ".\jarsigner.exe -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore " + $caminho.Aplicacao + "\" + $arquivo.chave + " "+ $caminho.Aplicacao + "\" + $arquivo.apk + " temp_cert"
}

#Verifica se já existe o arquivo de log já existe no destino
if(Test-Path ($caminho.Aplicacao + "\" + $arquivo.log)) {
    Remove-Item ($caminho.Aplicacao + "\" + $arquivo.log)
}

Start-Transcript -Path ($caminho.Aplicacao + "\" + $arquivo.log) -append

#entrar na pasta da aplicação
Set-Location -Path (Join-Path $caminho.Aplicacao "\AppTeste")

#gera o build para android
iex $comando.build

#Verifica se já existe o arquivo no destino
if(Test-Path ($caminho.Aplicacao + "\" + $arquivo.apk)) {
    Remove-Item ($caminho.Aplicacao + "\" + $arquivo.apk)
}

#copiar o arquivo gerado para outra pasta
Copy-Item (Join-Path $caminho.Aplicacao "\AppTeste\src-cordova\platforms\android\app\build\outputs\apk\release\app-release-unsigned.apk") -Destination $caminho.Aplicacao

#renomeia o item
Rename-Item -Path (Join-Path $caminho.Aplicacao "\app-release-unsigned.apk") -NewName $arquivo.apk

#entrar no java jdk
Set-Location -Path $caminho.jdk

#assina o .apk
iex $comando.assinar

Stop-Transcript



