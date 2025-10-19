import k8s.api.core.v1 as core_v1

schema ServiceAccount[v: str, n: str]:
    serviceAccount: core_v1.ServiceAccount = core_v1.ServiceAccount {
        metadata = {
            name = v,
            namespace = n,
        },
    }