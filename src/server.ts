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
            userId: body.userId,
            placeId: place.id
        }
    })

    return response.status(201).json(place);
});

app.post('/place/join', async (request, response) => {
    const body: any = request.body;

    const UserPlace = await prisma.userPlace.create({
        data:{
            userId: body.userId,
            placeId: body.placeId
        }
    })

    return response.status(201).json(UserPlace);
});

app.get('/user/:id/places', async (request, response) => {
    const idUser: string = request.params.id;

    const UserPlaces = await prisma.place.findMany({
       include:{
            _count: {
                select: {
                    users: true
                }
            }
        }, 
        where:{ 
            users: {
                some: {
                    userId: {
                        equals: idUser
                    }
                }
            }
        },
    })

    return response.status(200).json(UserPlaces);
});

app.listen(5556)