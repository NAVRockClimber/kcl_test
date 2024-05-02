import konfig.models.kube.frontend
import konfig.models.kube.frontend.container
import template.resource as res

appConfiguration: frontend.Server {
    mainContainer = container.Main {
        ports = [
            {containerPort = 8080}
        ]
    }
    image = "nginxinc/nginx-unprivileged:1.25.5-bookworm-perl"
    schedulingStrategy.resource = res.micro
}