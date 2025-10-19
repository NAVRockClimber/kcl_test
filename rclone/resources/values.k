# values.k

schema Values[v: any]:
    appName: str = v?.name or "my-cronjob"
    namespace?: str = v?.namespace or "test-namespace"
    serviceAccountName: str = v?.serviceAccountName or appName + "-sa"

    _cronJobDefaults: CronJobValues = CronJobValues(appName)
    CronValues: CronJobValues(_cronJobDefaults.name) {
        name = appName
        namespace = namespace
        suspend = v?.CronValues?.suspend or _cronJobDefaults.suspend
        concurrencyPolicy = v?.CronValues?.concurrencyPolicy or _cronJobDefaults.concurrencyPolicy
        failedJobsHistoryLimit = v?.CronValues?.failedJobsHistoryLimit or _cronJobDefaults.failedJobsHistoryLimit
        successfulJobsHistoryLimit = v?.CronValues?.successfulJobsHistoryLimit or _cronJobDefaults.successfulJobsHistoryLimit
        backoffLimit = v?.CronValues?.backoffLimit or _cronJobDefaults.backoffLimit
        ttlSecondsAfterFinished = v?.CronValues?.ttlSecondsAfterFinished or _cronJobDefaults.ttlSecondsAfterFinished
        restartPolicy = v?.CronValues?.restartPolicy or _cronJobDefaults.restartPolicy
        serviceAccountName = serviceAccountName
        schedule = v?.CronValues?.schedule or _cronJobDefaults.schedule
        image = v?.CronValues?.image or _cronJobDefaults.image
        tag = v?.CronValues?.tag or _cronJobDefaults.tag
        command = v?.CronValues?.command or _cronJobDefaults.command
    }
    ServiceAccount?: ServiceAccountValues{
        name = v?.CronValues?.serviceAccountName or appName + "-sa"
        namespace = v?.namespace or None
    }

schema CronJobValues[cronJobName: str]:
    name: str = cronJobName
    namespace?: str
    suspend?: bool = False
    concurrencyPolicy: str = "Allow"
    failedJobsHistoryLimit: int = 5
    successfulJobsHistoryLimit: int = 5
    backoffLimit: int = 3
    ttlSecondsAfterFinished: int = 518400
    restartPolicy: str = "OnFailure"
    serviceAccountName?: str
    schedule: str = "0 10 * * *"
    image: str = "rclone/rclone"
    tag: str = "latest"
    command: str = 'rclone copy $REMOTE_A_NAME:"$REMOTE_A_BUCKET/" $REMOTE_B_NAME:"$REMOTE_A_BUCKET/" --config $RCLONE_CONFIG_FILE --log-level=DEBUG --retries=1 --fast-list --progress --ignore-checksum --metadata --metadata-include "tier=STANDARD"'

schema ServiceAccountValues:
    name: str
    namespace?: str
