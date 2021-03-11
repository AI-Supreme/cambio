import { PrismaClient } from "@prisma/client";


const prisma = new PrismaClient();

const getCountries = async () => {
  return await prisma.countries.findMany();
}

export default getCountries