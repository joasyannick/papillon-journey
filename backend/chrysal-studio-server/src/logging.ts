type Level = 'failure' | 'error' | 'warning' | 'info' | 'flow' | 'snapshot'

const log = ( level: Level, message: string ) => console.log( `[${ level }] ${ message }` )

const logger = {
    failure: ( message: string ) => log( 'failure', message ),
    error: ( message: string ) => log( 'error', message ),
    warning: ( message: string ) => log( 'warning', message ),
    info: ( message: string ) => log( 'info', message ),
    controlFlow: ( message: string ) => log( 'flow', message ),
    snapshot: ( message: string ) => log( 'snapshot', message ),
  }

export default logger