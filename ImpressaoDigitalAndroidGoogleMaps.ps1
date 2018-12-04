#entrar no java jdk
$jdk = 'C:\Program Files\java\jdk1.8.0_172\bin'
Set-Location -Path $jdk

.\keytool.exe -list -v -keystore C:\Users\marconi.barroso\Desktop\APP\temporaria.keystore > 'C:\Users\marconi.barroso\Desktop\APP\impressaoDigitalAndroidGoogleMaps.txt'