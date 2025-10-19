import helpers

helmCronJob = helpers.getObjectTypeFromManifest("test_data/manifest.yaml", "CronJob")
kclCronJob= helpers.getObjectTypeFromManifest("kcl-output.yaml", "CronJob")

test_cronjob_name = lambda {
        msg=str(kclCronJob.metadata.name) + " != " + str(helmCronJob.metadata.name)
        assert helmCronJob.metadata.name == kclCronJob.metadata.name, msg
}

test_spec = lambda {
        kclCronJob.spec.jobTemplate = None
        helmCronJob.spec.jobTemplate = None
        msg=str(kclCronJob.spec) + " != " + str(helmCronJob.spec)
        assert helmCronJob.spec == kclCronJob.spec, msg
}

test_jobTemplateSpec = lambda {
        kclCronJob.spec.jobTemplate.spec.template = None
        helmCronJob.spec.jobTemplate.spec.template = None
        msg=str(kclCronJob.spec.jobTemplate) + " != " + str(helmCronJob.spec.jobTemplate)
        assert helmCronJob.spec.jobTemplate == kclCronJob.spec.jobTemplate, msg
}

test_jobTemplateSpecTemplate: () -> any = lambda {
        kclCronJob.spec.jobTemplate.spec.template.spec.containers = None
        kclCronJob.spec.jobTemplate.spec.template.spec.securityContext = None
        kclCronJob.spec.jobTemplate.spec.template.spec.containers = None
        kclCronJob.spec.jobTemplate.spec.template.spec.volumes = None
        helmCronJob.spec.jobTemplate.spec.template.spec.containers = None
        helmCronJob.spec.jobTemplate.spec.template.spec.volumes = None
        helmCronJob.spec.jobTemplate.spec.template.spec.securityContext = None
        msg=str(kclCronJob.spec.jobTemplate.spec.template.spec) + " != " + str(helmCronJob.spec.jobTemplate.spec.template.spec)
        assert helmCronJob.spec.jobTemplate.spec.template.spec == kclCronJob.spec.jobTemplate.spec.template.spec, msg
}