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

app.post('/user', async (request, response) => {

    const body: any = request.body;

    const user = await prisma.user.create({
        data: {
            name: body.name,
            email: body.email,
            password: body.password,
        }
    })

    return response.status(201).json(user);
});

app.post('/place', async (request, response) => {
    const body: any = request.body;

    const place = await prisma.place.create({
        data: {
            name: body.placeName,
        }
    })

    await prisma.userPlace.create({
        data:{
            Userid: body.userId,
            Placeid: place.id
        }
    })

    return response.status(201).json(place);
});

app.post('/place/join', async (request, response) => {
    const body: any = request.body;

    const UserPlace = await prisma.userPlace.create({
        data:{
            Userid: body.userId,
            Placeid: body.placeId
        }
    })

    return response.status(201).json(UserPlace);
});

app.listen(5556)