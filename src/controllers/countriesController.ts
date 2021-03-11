import { Request, Response } from "express";
import saveCurrencies, { CurrencyData } from "../entity/country/create";

export default {
  async create(request: Request, response: Response) {
    const currencies = request.body;
    const data: CurrencyData[] = currencies;

    await saveCurrencies(data)
    
    response.status(200).json({message: 'Countries saved!!'})
  }
}