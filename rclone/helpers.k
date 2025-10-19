import file
import yaml

getObjectTypeFromManifest = lambda manifestFile: str, KindType: str {
    manifest_string = file.read(manifestFile)
    manifestObjects = yaml.decode_all(manifest_string)
    manifestObject = [doc for doc in manifestObjects if doc?.kind == KindType][0]

    manifestObject
}