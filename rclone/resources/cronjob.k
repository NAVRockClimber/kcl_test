# cronjob.k
import k8s.api.batch.v1 as batch_v1
import resources.values as values

schema CronJob[v: values.CronJobValues]:
    cronJob: batch_v1.CronJob = batch_v1.CronJob {
        metadata = {
            name = v.name,
            namespace = v.namespace,
        },
        spec = {
            schedule = v.schedule,
            suspend = v.suspend,
            concurrencyPolicy = v.concurrencyPolicy,
            failedJobsHistoryLimit = v.failedJobsHistoryLimit
            successfulJobsHistoryLimit = v.successfulJobsHistoryLimit
            jobTemplate = {
                spec = {
                    backoffLimit = v.backoffLimit,
                    ttlSecondsAfterFinished = v.ttlSecondsAfterFinished,
                    template = {
                        metadata = {
                            labels = {
                                app = v.name,
                            },
                        },
                        spec = {
                            restartPolicy = v.restartPolicy,
                            serviceAccountName = v.serviceAccountName,
                            containers = [
                                {
                                    name  = v.name,
                                    image = v.image + ":" + v.tag,
                                    command = ["/bin/sh"],
                                    args = ["-c", v.command],
                                }
                            ],
                            restartPolicy = "OnFailure",
                        },
                    },
                },
            },
        },
    }