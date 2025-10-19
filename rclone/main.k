import resources.values as values
import resources.cronjob as cronjob
import resources.serviceaccount as serviceaccount
import manifests


appSettings = option("app")
overlaySettings = option("overlay", default={})
appValues = values.Values(appSettings)
print("Using AppValues: " + str(appValues))

cronResource = cronjob.CronJob(appValues.CronValues).cronJob

if appValues.serviceAccountName != None:
    serviceaccountResource = serviceaccount.ServiceAccount(appValues.serviceAccountName, appValues.CronValues.namespace).serviceAccount


resourcesList: [any] = [cronResource, serviceaccountResource]
manifests.yaml_stream(resourcesList)