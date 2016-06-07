# iCanGO-iOS

## Models
## ------
### Resource.swift
Modela los datos un recurso de red.
Define un protocolo con los datos de un resource (method, path y parameters)
Se define un metodo NSURL (base) -> NSURLRequest.

### APIRequest.swift
Implementa el protocolo Resource, encapsulando las distintas peticiones.

### JSONDecodable.swift
Contiene typeAlias de lo que consideramos un diccionario de JSON: JSONDictionary.
Define el protocolo JSONDecodable, que implementaran aquellos objetos de nuestro modelo que se puedan crear a partir de un JSONDictionary. 
Define funciones para la decodificacion del JSON.

### Service.swift
Define Struct con los datos del servicio. Implementa el protocolo JSONDecodable para crearse a partir de un JSONDictionary.

### Session.swift
Crea un NSURLSession a partir de una URL Base.
Define la funcion "data" que crea y devuelve un observable<NSData> 
Contiene enum con los errores relativos a la peticion.

### iCanGoSession.swift
Define extension para obtener objetos que cumplan con el protocolo JSONDecodable.
Define extension para relalizar las peticiones definidas en APIRequest.


## Helpers
## -------
### Framework.swift
Crea extension de NSDate para devolver un NSDate a partir de una fecha y hora.


## Common
## ------
### Constant.swift
Contiene constantes comunes a toda la app.








## Documentacion Funcionamiento Peticiones
## ---------------------------------------
1. Desde delegate, nos suscribimos al observable que nos devuelve los servicios, pasandole el path de la peticion mocky 
correspondiente al los servicios. Podemos tener mas numeros de peticiones a mocky, o lo que es lo mismo, diferentes peticiones.

2. En ICanGoSession.swift, se ejecuta la funcion getServices que lanza a su vez, la funcion getObjects dentro de este archivo.

3. La funcion getObjects(), llama al metodo data del archivo: Session.swift. Aqui es donde se crea el observable.

4. Se realiza la peticion.

5. Cuando la peticion se completa, se ejecuta el bloque del metodo getObjects() del archivo: ICanGoSession.swift, que en primer
lugar decodifica el JSON, obteniendo objetos Services, que se devuelven.

6. Volvemos al delegate con los servicios.


