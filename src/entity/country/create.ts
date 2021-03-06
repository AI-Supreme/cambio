import { PrismaClient } from "@prisma/client";

export interface countryData {
  name: string
  currency: string
  symbol: string
}

const prisma = new PrismaClient();

const saveCountry = async (countries: countryData[]) => {
  const savedCountries = countries.map(async country => {
    const { name, currency, symbol } = country;

    const foundCountry = await prisma.countries.findUnique({where: {name}});
    if(foundCountry) return
    
    return await prisma.countries.create({
      data: {
        name, 
        symbol,
        currency: {
          connectOrCreate: {
            where: { currency },
            create: { currency }
          }
        }
      },
      include: { currency: true}
    })
  })

  return savedCountries
}

export default saveCountry;