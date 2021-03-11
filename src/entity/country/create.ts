import { PrismaClient } from "@prisma/client";

export interface CountryData {
  name: string
  currency: string
  symbol: string
  iso_4217: string
}

const prisma = new PrismaClient();

const saveCurrencies = async (countries: CountryData[]) => {
  const savedCountries = countries.map(async country => {
    const { name, currency, symbol, iso_4217 } = country;

    const foundCountry = await prisma.countries.findUnique({where: {name}});
    if(foundCountry) return
    
    return await prisma.countries.create({
      data: {
        name,
        iso_4217,
        currency: {
          connectOrCreate: {
            where: { name_symbol: { name: currency, symbol } },
            create: {name: currency, symbol}
          }
        }
      },
      include: { currency: true }
    }).catch(err => console.log(err)
    )
  })

  return savedCountries
}

export default saveCurrencies;