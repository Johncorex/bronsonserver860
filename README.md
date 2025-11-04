# Bronson Server 8.6 Rebuild

Using Nekiro's TFS 1.3/1.4 downgrade to 8.6

https://github.com/nekiro/TFS-1.5-Downgrades/tree/8.60

This downgrade is not download and run distribution, monsters and spells are probably not 100% correct.


This downgrade is up to Dec 21, 2021, commit: https://github.com/otland/forgottenserver/commit/17bf638815fa7c04d5b723baa8e0bfbdaad341f2

## Other distributions:

#### **[7.72](https://github.com/nekiro/TFS-1.4-Downgrades/tree/7.72)**

#### **[8.0](https://github.com/nekiro/TFS-1.4-Downgrades/tree/8.0)**

## How to compile
https://otland.net/threads/tfs-1-3-8-6-compiling-errors.263594/#post-2548089

git clone https://github.com/Microsoft/vcpkg

cd vcpkg

.\bootstrap-vcpkg.bat

.\vcpkg integrate install

--32X

.\vcpkg install boost-iostreams:x86-windows boost-asio:x86-windows boost-system:x86-windows boost-variant:x86-windows boost-lockfree:x86-windows luajit:x86-windows libmariadb:x86-windows pugixml:x86-windows mpir:x86-windows cryptopp:x86-windows

--64X

.\vcpkg install boost-iostreams:x64-windows boost-asio:x64-windows boost-system:x64-windows boost-variant:x64-windows boost-lockfree:x64-windows luajit:x64-windows libmariadb:x64-windows pugixml:x64-windows mpir:x64-windows cryptopp:x64-windows

After libraries installed, Run visual studio 2017 community as Administrator then choose

File > Open > Project Solution > theforgottenserver.vcxproj

Then right click on your project and "Rebuild"

I had to install up to date Mariadb and the rest I installed using 2019 commits.
