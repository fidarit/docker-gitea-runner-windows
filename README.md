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
