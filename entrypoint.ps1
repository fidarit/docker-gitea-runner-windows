# Set the labels if given
if ($null -ne $env:GITEA_RUNNER_LABELS) { 
  $LABELS = $env:GITEA_RUNNER_LABELS
} else {
  $LABELS = 'windows:host'
}

$GITEA_RUNNER_NAME = $env:GITEA_RUNNER_NAME
$GITEA_INSTANCE_URL = $env:GITEA_INSTANCE_URL
$GITEA_RUNNER_REGISTRATION_TOKEN = $env:GITEA_RUNNER_REGISTRATION_TOKEN

try {
  Write-Host "Configuring runner: $GITEA_RUNNER_NAME"
  ./act_runner.exe register --no-interactive --instance $GITEA_INSTANCE_URL --token $GITEA_RUNNER_REGISTRATION_TOKEN --name $GITEA_RUNNER_NAME --labels $LABELS

  # Remove access token for security reasons
  $env:ACCESS_TOKEN=$null

  ./act_runner.exe daemon
} catch {
  Write-Error $_.Exception.Message
}