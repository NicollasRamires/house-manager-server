import express, { query, request, response } from 'express'
import cors from 'cors'

import { PrismaClient } from '@prisma/client'

const app = express()
app.use(express.json())
app.use(cors({
   // origin: 'http://'
}))

const prisma = new PrismaClient({
    log: ['query'] // serve para logar no console o comando SQL executado pelas rotas
})

app.get('/houses', async (request, response) => {

    const houses = await prisma.house.findMany()

    return response.json(houses);
});

app.listen(5555)