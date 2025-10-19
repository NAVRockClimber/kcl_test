import resources.cronjob as cronjob
import resources.values as values
import resources.serviceaccount as serviceaccount
import manifests
import file
import yaml

# 1. Optionale YAML-Datei aus CLI:  -D values=overrides.yaml
values_file = option("values", default=None)

# 2. Falls Datei angegeben, lade sie und dekodiere YAML → Dict
if values_file:
    yaml_str = file.read(values_file)
    yaml_overrides = yaml.decode(yaml_str)

# 4. Merge: Defaults + YAML-Datei + CLI (CLI hat höchste Priorität)
final_values = values.Defaults { **yaml_overrides }


cronResource = cronjob.CronJob(final_values.CronValues).cronJob

if final_values.serviceAccountName != None:
    serviceaccountResource = serviceaccount.ServiceAccount(final_values.serviceAccountName, final_values.CronValues.namespace).serviceAccount 


resourcesList: [any] = [cronResource, serviceaccountResource]
manifests.yaml_stream(resourcesList)