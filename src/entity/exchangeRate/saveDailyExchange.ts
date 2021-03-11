import { PrismaClient } from "@prisma/client";
import { parse } from "date-fns";

const prisma = new PrismaClient()

const isObject = (dailyExchangeRate: any) => (
  dailyExchangeRate || typeof dailyExchangeRate !== 'string' || typeof dailyExchangeRate !== 'number'
)

const saveDailyExchange = async (dailyExchangeRate: any, country_id: number) => {
  if(isObject(dailyExchangeRate)) {
    const keys = Object.keys(dailyExchangeRate);
    
    keys.forEach(async key => {
      await prisma.daily_exchange.create({
        data: {
          countries: {
            connect: { id: country_id }
          },
          date: parse(key, 'yyyy-MM-dd', new Date()),
          open: dailyExchangeRate[key]['1. open'],
          high: dailyExchangeRate[key]['2. high'],
          low: dailyExchangeRate[key]['3. low'],
          close: dailyExchangeRate[key]['4. close']
        }
      })
    })
  }

  console.log('Wrong type', dailyExchangeRate);
}

export default saveDailyExchange;