@echo off
setlocal

set MVNW_REPOURL=https://repo.maven.apache.org/maven2
set MAVEN_PROJECTBASEDIR=%~dp0
set MAVEN_WRAPPER_JAR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar

if not exist "%MAVEN_WRAPPER_JAR%" (
  echo Downloading Maven Wrapper...
  mkdir "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper" >nul 2>&1
  powershell -Command "Invoke-WebRequest -Uri %MVNW_REPOURL%/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar -OutFile %MAVEN_WRAPPER_JAR%"
)

set JAVA_CMD=java
"%JAVA_CMD%" ^
  -classpath "%MAVEN_WRAPPER_JAR%" ^
  -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%" ^
  org.apache.maven.wrapper.MavenWrapperMain %*

endlocal
