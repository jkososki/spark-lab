$workdir = (Get-Location).Path
$spark_version = "2.4.4"
$images = @("base", "master", "submit", "worker")

try {
    foreach ($img in $images) {
        set-location "$workdir\spark-$img"
        Invoke-Expression "docker build -t spark-$img`:$spark_version ."
    }
}
catch {
    set-location $workdir
    throw
}
set-location $workdir