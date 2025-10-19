
import .app

app.App {
    name = "app"
    containers.nginx = {
        image = "nginx"
        ports = [{containerPort = 80}]
    }
    service.ports = [{ port = 80 }]
}

manifests.yaml_stream(sum([kubernetesRender(a) for a in app.App.instances()], []))
