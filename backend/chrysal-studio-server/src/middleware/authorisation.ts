import { Request, Response, NextFunction } from 'express'
import jwt from 'jsonwebtoken'
import { Ok } from 'neverthrow'
import getConfiguration from '@/configuration'
import type { Configuration } from '@/configuration'

export interface AuthorisedRequest extends Request {
    userId?: string
  }

const jwtSecret = ( getConfiguration() as Ok< Configuration, never > ).value.jwtSecret // We know this is ok because the server won't start otherwise

export const authorise = ( request: AuthorisedRequest, response: Response, next: NextFunction ) => {
    const authorization = request.headers.authorization
    if ( ! authorization ) return void response.status( 401 ).json()
    const token = authorization.split( ' ' )[ 1 ]
    try {
        // We need Zod here too?
        const payload = jwt.verify( token, jwtSecret ) as { userId: string } // Logical coupling with '@/routes/authentication' regarding the token structure
        request.userId = payload.userId
        next()
      } catch ( error ) {
        console.error( error )
        return void response.status( 401 ).json()
      }
  }