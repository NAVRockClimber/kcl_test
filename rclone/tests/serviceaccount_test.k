kclServiceAccount= helpers.getObjectTypeFromManifest("kcl-output.yaml", "ServiceAccount")

test_serviceAccount_name = lambda {
    kclCronJob= helpers.getObjectTypeFromManifest("kcl-output.yaml", "CronJob")
    cronJobServiceAccountName = kclCronJob.spec.jobTemplate.spec.template.spec.serviceAccountName
    msg=str(kclServiceAccount.metadata.name) + " != " + cronJobServiceAccountName
    assert kclServiceAccount.metadata.name == cronJobServiceAccountName, msg
}