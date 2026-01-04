//
//  UserMapper.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

// Classe permettant le passage des DTO aux Entités
class UserMapper {
    
   static func map2User(userDTO: UserDTO) -> User {
        
        return User(
            email: userDTO.email,
            password: userDTO.password,
            firstName: userDTO.firstName,
            lastName: userDTO.lastName)
    }
    
    static func map2DTO(user: User) -> UserDTO {
        
        return UserDTO(
            email: user.email,
            password: user.password,
            firstName: user.firstName,
            lastName: user.lastName)
    }
        
    static func map2IdDTO(credentials: Credentials) -> IdDTO {
        return IdDTO(email : credentials.email,
                     password: credentials.password)
        
    }
    
    static func map2Credentials(idDTO: IdDTO) -> Credentials {
        return Credentials(email: idDTO.email,
                           password: idDTO.password)
    }
    
    static func map2LoggedInUser(token: TokenDTO) -> LoggedInUser {
        return LoggedInUser(accessToken: token.accessToken,
                            isAdmin: token.isAdmin)
        
    }
}
