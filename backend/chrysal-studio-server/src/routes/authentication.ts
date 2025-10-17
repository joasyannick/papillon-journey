import { Router } from 'express'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import { PrismaClient } from '@prisma/client'
import * as z from 'zod'
import { Ok } from 'neverthrow'
import getConfiguration from '@/configuration'
import type { Configuration } from '@/configuration'

const jwtSecret = ( getConfiguration() as Ok< Configuration, never > ).value.jwtSecret // We know this is ok because the server won't start otherwise
const router = Router()
const prismaClient = new PrismaClient()
const validCredentials = z.object( {
    email: z.email(),
    password: z.string().min( 6 )
  } )

router.post( '/register', async ( request, response ) => {
    const parsed = validCredentials.safeParse( request.body )
    if ( ! parsed.success ) return void response.status( 400 ).json()
    const { email, password } = parsed.data
    try {
        const existingUser = await prismaClient.user.findUnique( { where: { email } } )
        if ( existingUser ) return void response.status( 400 ).json()
        const hashedPassword = await bcrypt.hash( password, 10 )
        const newUser = await prismaClient.user.create( { data: { email, password: hashedPassword } } )
        const token = jwt.sign( { userId: newUser.id }, jwtSecret ) // Zod?
        response.json( { token } )
      } catch ( error ) {
        console.error( error )
        response.status( 500 ).json()
      }
  } )

router.post( '/login', async ( request, response ) => {
    const parsed = validCredentials.safeParse( request.body )
    if ( ! parsed.success ) return void response.status( 400 ).json()
    const { email, password } = parsed.data
    try {
        const user = await prismaClient.user.findUnique( { where: { email } } )
        if ( ! user ) return void response.status( 401 ).json()
        const valid = await bcrypt.compare( password, user.password )
        if ( ! valid ) return void response.status( 401 ).json()
        const token = jwt.sign( { userId: user.id }, jwtSecret )
        response.json( { token } )
      } catch ( error ) {
        console.error( error )
        response.status( 500 ).json()
      }
  } )

export default router