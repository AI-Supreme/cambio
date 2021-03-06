import { Request, Response } from "express";
import saveCountry, { countryData } from "../entity/country/create";

export default {
  async create(request: Request, response: Response) {
    const countries = request.body;
    const data: countryData[] = countries;

    await saveCountry(data)
    
    response.status(200).json({message: 'Countries saved!!'})
  }
}