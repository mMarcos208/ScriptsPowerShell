#entrar no java jdk
$jdk = 'C:\Program Files\java\jdk1.8.0_172\bin'
Set-Location -Path $jdk

.\keytool.exe -exportcert -alias androiddebugkey -keystore C:\Users\marconi.barroso\Desktop\APP\temporaria.keystore | C:\OpenSSL-Win32\bin\openssl sha1 -binary | C:\OpenSSL-Win32\bin\openssl base64 >> 'C:\Users\marconi.barroso\Desktop\APP\hashFacebook.txt'