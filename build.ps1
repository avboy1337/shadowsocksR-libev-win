Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent)

git clone https://github.com/shadowsocksrr/shadowsocksr-libev -b 'Akkariiin/develop' src
if ( -Not $? ) {
    exit $lastExitCode
}
Set-Location src
git apply ..\ssr.diff
msys2 ..\build.sh
# if ( -Not $? ) {
#     exit $lastExitCode
# }