# iCanGO-iOS
## Models

### Resource.swift
Modela los datos un recurso de red.
##### protocol Resource 
Define un protocolo con los datos de un resource (method, path y parameters)
##### protocol Extension de Resource
Se define un metodo que a partir de un NSURL (base) devuelve un objeto NSURLRequest.

### APIRequest.swift
Implementa el protocolo Resource, encapsulando las distintas peticiones.

### JSONDecodable.swift
Define el protocolo JSONDecodable, que implementaran aquellos objetos de nuestro modelo que se puedan crear a partir de un
JSONDictionary. Contiene typeAlias de lo que consideramos un diccionario de JSON.



