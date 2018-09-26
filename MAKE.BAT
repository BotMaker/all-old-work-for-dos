@echo off

mkdir c:\euphoria
mkdir c:\euphoria\include
mkdir c:\euphoria\doc
copy /b a:\euphoria\include\*.* c:\euphoria\include
copy /b a:\*.* c:\euphoria
copy /b a:\doc\*.* c:\euphoria\doc
cd c:\euphoria

