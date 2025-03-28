//
//  APISession.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation


/// Donde ejecutamos la petición al servidor
protocol APISessionContract {
    /// Recibe un objeto Request que conforma a HTTPRequest y devuelve un resultado que es un dato en crudo o un error
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void)
}


/// Elegimos el motor para impplementar la llamada, en nuestro caso creamos nuestra propia implementación
struct APISession: APISessionContract {
    
    static var shared: APISessionContract = APISession()
    
    ///Preparamos una sesión de url, aquí es donde va el URLSession
    private let session: URLSession
    private let requestInterceptor: [APIRequestInterceptor]
    
    init(configuration: URLSessionConfiguration = .default,
        requestInterceptor: [APIRequestInterceptor] = [AuthenticationAPIInterceptor()]) {
        self.requestInterceptor = requestInterceptor
        self.session = URLSession(configuration: configuration)
    }
    
    
    
    func request<Request>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) where Request : HTTPRequest {
        
        do {
            //Obtenemos el objeto de urlSesion de la request
            var request = try apiRequest.getRequest()
            //Ejecutar la peticion de red, la cual ha pasado antes por todos los interceptores
            requestInterceptor.forEach { request  = $0.intercept(request)} // $0.intercept(&request) el & la referencia de donde está la variable, cuando es un inout
            session.dataTask(with: request) { data, response, error in
                if let error {
                    return completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return completion(.success( data ?? Data())) // Si todo ha ido bien devolvemos el data, en caso de no haber data devolvemos uno vacio pues siempre hay que devolver algo. Ej:  /api/data/herolike el cual se usa para marcar un héroe como favorito es un ejemplo de empy data
                default :
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
}

