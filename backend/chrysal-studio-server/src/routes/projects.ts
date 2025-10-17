import { Router } from 'express'
import { PrismaClient } from '@prisma/client'
import { authorise, AuthorisedRequest } from '@/middleware/authorisation'

const router = Router()

router.post('/', authorise, async ( request: AuthorisedRequest, response ) => {
    response.json( { message: 'Project route works!' } )
  } )

export default router