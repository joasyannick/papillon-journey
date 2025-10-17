import express from 'express'
import cors from 'cors'
import authenticationRoutes from '@/routes/authentication'
import projectRoutes from '@/routes/projects'
import getConfiguration from '@/configuration'

const app = express()
app.use( cors() )
app.use( express.json() )

app.use( '/api/authentication', authenticationRoutes )
app.use( '/api/projects', projectRoutes )

const configuration = getConfiguration()
if ( configuration.isOk()) {
  app.listen( configuration.value.port, () => void console.log( `Running on port ${ configuration.value.port }` ) ) // What is this callback doing?
}