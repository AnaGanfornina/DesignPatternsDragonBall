//
//  HTTPRequest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//
import Foundation
// Como definimos una peticion de red, una request. Como es su fisionomia, pero no su implementación, pues eso es lo que meteremos en cada uno de los flujos que nosotros queramos

/// Petición HTTP, es el elemento mínimo de nuestro cliente de red
protocol HTTPRequest {
    
    associatedtype Response: Decodable // manera de poner un generico en un protocolo
    
    typealias APIRequestResponse = Result<Response, APIErrorResponse>
    ///El resultado de la petición
    typealias APIRequestCompletion = (APIRequestResponse) -> Void
    
     
    // La petición se define por los siguientes campos
    var method: Methods { get }
    
    var host: String { get } // "Google.com" / "dragonball.keepcoding.education"
    var path: String { get } //  "/api/heros/all"
    var queryParameters: [String: String] { get } // parámetros dentro de la url
    var headers: [String: String] { get } // "Soy safari, soy el navegador de españa..."No son tan criticas para la app
    var body: Encodable? { get } //aplica en algunos casos si otros no. Un get no puede tener body
}

extension HTTPRequest {
    var host: String { "dragonball.keepcoding.education" }
    var queryParameters: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
    
    func getRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !queryParameters.isEmpty{
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            fatalError("Invalid URLComponents")
        }
        
        // Configuración de los campos específicos de la petición: metodo, cabecera y body
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body, method != .GET {
            request.httpBody = try JSONEncoder().encode(body) // SI hay un body y no es un get, codificamelo
        }
        request.timeoutInterval = 30 // Para no hacer esperar al usuario
        
        //Configuramos las cabeceras
        request.allHTTPHeaderFields = ["Accept": "application/json", "Content-Type": "application/json"]
            .merging(headers) { $1 } // para permitir una extensión en un futuro si alguien quiere trabajar con otro tipo de cabeceras. Priorizando las que me setee el desarrollador en la cabecera de mi petición
        return request
    }
    
    /// Ejecuta la peticion de red sobre una sesion
    func perform(session: APISessionContract = APISession.shared, completion: @escaping APIRequestCompletion){
        session.request(apiRequest: self) { result in
            do{
                let data = try result.get()
                
                // ¿Qué pasa si yo no espero nada de respuesta?
                if Response.self == Void.self {
                    return completion(.success(() as! Response)) // Si el response es un void porque no queramos ninguna respuesta tiramos para alante
                } else if Response.self == Data.self {
                    return completion(.success(data as! Response))// Si el response es un  data porque queremos el valor en crudo retornamos el data. Ej: una imagen
                }
                return try completion(.success(JSONDecoder().decode(Response.self, from: data))) // Si es un objeto que es encodable, lo decodificamos y retornamos el objeto ya parseado
                
            } catch let error as APIErrorResponse {
                completion(.failure(error))
            } catch let error as DecodingError {
                completion(.failure(APIErrorResponse.parseData(path)))
            }catch {
                completion(.failure(APIErrorResponse.unknown(path)))
            }
        
        }
    }
}
