import { ok, err, Result } from 'neverthrow'
import log from '@/logging'

export type Configuration = { readonly port: number, readonly jwtSecret: string } 

type ConfigurationError = EnvironmentVariableNotSet | InvalidValue

type EnvironmentVariableNotSet = { readonly environmentVariable: string }

type InvalidValue = { readonly configurationParameter: string, readonly value: string }

const readEnvironmentVariable = < Value >
  (
    name: string,
    validator: ( _: string ) => Result< Value, InvalidValue >
  ):
  Result< Value, ConfigurationError > =>
  {
    const stringValue = process.env[ name ]
    if ( ! stringValue ) {
      log.warning( `Environment variable ${ name } is not set.` )
      return err( { environmentVariable: name } )
    }
    const value = validator( stringValue.trim() )
    return value.isErr() ? err( value.error ) : ok( value.value )
  }

let configuration = null as null | Configuration

const getConfiguration = (): Result< Configuration, ConfigurationError > => {
    if ( configuration ) return ok( configuration )
    const validatePort = ( value: string ) => /^\d+$/.test( value ) ? ok( Number( value ) ) : err( { configurationParameter: 'port', value: value } )
    const port = readEnvironmentVariable( 'CHRYSAL_PORT', validatePort ).unwrapOr( 3000 )
    log.info( `Using port ${ port }` )
    const validateJwtSecret = ( value: string ) => value ? ok( value ) : err( { configurationParameter: 'jwtSecret', value: value } )
    const jwtSecret = readEnvironmentVariable( 'CHRYSAL_JWT_SECRET', validateJwtSecret )
    if ( jwtSecret.isErr() ) {
        log.failure( `Invalid JWT secret. Set the environment variable CHRYSAL_JWT_SECRET to a non-empty value.` )
        return err( jwtSecret.error )
      }
    configuration = { port: port, jwtSecret: jwtSecret.value }
    return ok( configuration )
  }

export default getConfiguration