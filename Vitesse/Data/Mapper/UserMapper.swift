//
//  UserMapper.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

class UserMapper {
    
   static func map(userDTO: UserDTO, tokenDTO: TokenDTO) -> User {
        
        return User(
            email: userDTO.email,
            password: userDTO.password,
            firstName: userDTO.firstName,
            lastName: userDTO.lastName,
            accessToken: tokenDTO.accessToken,
            isAdmin: tokenDTO.isAdmin)
    }
}
