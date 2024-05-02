import konfig.models.kube.frontend
import template.resource as res

appConfiguration : frontend.Server {
    schedulingStrategy.resource = res.tiny
}
