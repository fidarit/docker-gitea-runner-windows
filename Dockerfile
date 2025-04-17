ARG SERVERCORE_VERSION="ltsc2022"
FROM mcr.microsoft.com/windows/servercore:${SERVERCORE_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# disable telemetry
ENV POWERSHELL_TELEMETRY_OPTOUT="1"

# Set working directory
WORKDIR /actions-runner

COPY install-choco.ps1 .
RUN .\install-choco.ps1; Remove-Item .\install-choco.ps1 -Force

# Install dependencies with Chocolatey
RUN choco install -y \
    git \
    gh \
    powershell-core \
    docker-cli \
    python \
	nodejs

RUN choco install -y visualstudio2022buildtools --package-parameters \" \
    --quiet --norestart \
    --add Microsoft.VisualStudio.Workload.VisualStudioExtensionBuildTools \
    --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools \
    --add Microsoft.NetCore.Component.SDK \
    --add Microsoft.Net.Component.4.8.TargetingPack \
    \"

# Add MSBuild to the path
RUN [Environment]::SetEnvironmentVariable(\"Path\", $env:Path + \";C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\", \"Machine\")
RUN [Environment]::SetEnvironmentVariable(\"Path\", $env:Path + \";C:\Program Files\Git\usr\bin\", \"Machine\")

ARG RUNNER_VERSION="0.2.11"
ADD https://gitea.com/gitea/act_runner/releases/download/v$RUNNER_VERSION/act_runner-$RUNNER_VERSION-windows-amd64.exe act_runner.exe

COPY entrypoint.ps1 .
ENTRYPOINT ["pwsh.exe", ".\\entrypoint.ps1"]