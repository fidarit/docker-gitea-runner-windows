# Windows Docker Gitea Runner

This repository is a Gitea version of the [tiobe/docker-github-runner-windows](https://github.com/tiobe/docker-github-runner-windows) runner for GitHub. 

This repository will run the [self-hosted gitea actions runners](https://gitea.com/gitea/act_runner) for Windows with [Visual Studio 2022 buildtools](https://community.chocolatey.org/packages/visualstudio2022buildtools) installed by default.

The build images can be found on [Docker Hub](https://hub.docker.com/r/fidarit/gitea-runner-windows).

## Environment variables

| Environment Variable              | Description                                                                                                                                                                                                                                                                                   |
| --------------------------------- | ------------------------------------------------------------------------------------------------- |
| `GITEA_RUNNER_NAME`               | The name of the runner to use.                                                                    |
| `GITEA_RUNNER_REGISTRATION_TOKEN` | The format of the registration token is a random string D0gvfu2iHfUjNqCYVljVyRV14fISpJxxxxxxxxxx. |
| `GITEA_RUNNER_LABELS`             | A comma separated string to indicate the labels. Default is 'windows:host'                        |
| `GITEA_INSTANCE_URL`              | URL of the Gitea server e.g gitea.mycompany.com.                                                  |


## docker-compose.yml example

```yml
volumes:
  runner_cache: {}
  runner_packages_cache: {}

services:
  runner:
    build: 
      context: .
      dockerfile: Dockerfile
    environment:
      GITEA_INSTANCE_URL: "http://myhost.mycompany.com:8080"
      GITEA_RUNNER_REGISTRATION_TOKEN: "abcdefghijklmnopqrstuvwxyz0123456789ABCD"
      GITEA_RUNNER_NAME: "windows-docker"
      GITEA_RUNNER_LABELS: "windows:host,windows-latest:host"
    volumes:
      - .\data:c:\actions-runner\data
      - runner_cache:c:\users\ContainerAdministrator\.cache
      - runner_packages_cache:c:\users\ContainerAdministrator\.nuget\packages
```