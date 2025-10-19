# values.k

schema Values[v: any]:
    app_name: str = option("app_name", default="my-cronjob")
    namespace: str = option("namespace", default="test-namespace")
    serviceAccountName: str = option("serviceAccountName", default=app_name + "-sa")

    CronValues: CronJobValues {
        name = app_name
        namespace = namespace
        suspend = option("suspend", default=False)
        concurrencyPolicy = option("concurrencyPolicy", default="Allow")
        failedJobsHistoryLimit = option("failedJobsHistoryLimit", default=5)
        successfulJobsHistoryLimit = option("successfulJobsHistoryLimit", default=5)
        backoffLimit = option("backoffLimit", default=3)
        ttlSecondsAfterFinished = option("ttlSecondsAfterFinished", default=518400)
        restartPolicy = option("restartPolicy", default="OnFailure")
        serviceAccountName = serviceAccountName
        schedule = option("schedule", default="0 10 * * *")
        image = option("image", default="rclone/rclone")
        tag = option("tag", default="latest")
        command = option("command", default='rclone copy $REMOTE_A_NAME:"$REMOTE_A_BUCKET/" $REMOTE_B_NAME:"$REMOTE_A_BUCKET/" --config $RCLONE_CONFIG_FILE --log-level=DEBUG --retries=1 --fast-list --progress --ignore-checksum --metadata --metadata-include "tier=STANDARD"')
    }

    ServiceAccount: ServiceAccountValues {
        name = serviceAccountName
        namespace = namespace
    }

schema CronJobValues:
    name: str = Values.CronValues.name
    namespace: str = Values.CronValues.namespace
    suspend: bool = Values.CronValues.suspend
    concurrencyPolicy: str = Values.CronValues.concurrencyPolicy
    failedJobsHistoryLimit: int = Values.CronValues.failedJobsHistoryLimit
    successfulJobsHistoryLimit: int = Values.CronValues.successfulJobsHistoryLimit
    backoffLimit: int = Values.CronValues.backoffLimit
    ttlSecondsAfterFinished: int = Values.CronValues.ttlSecondsAfterFinished
    restartPolicy: str = Values.CronValues.restartPolicy
    serviceAccountName?: str = Values.CronValues.serviceAccountName
    schedule: str = Values.CronValues.schedule
    image: str = Values.CronValues.image
    tag: str = Values.CronValues.tag
    command: str = Values.CronValues.command

schema ServiceAccountValues:
    name: str = Values.ServiceAccount.name
    namespace: str = Values.ServiceAccount.namespace

Defaults: Values = Values({})