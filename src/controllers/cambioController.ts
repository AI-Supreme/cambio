import { Request, Response } from "express";
import alphaVantageApi from "../services/alphaVantageApi";

export default {
  async index(request: Request, response: Response) {   
    const { from_symbol, to_symbol } = request.query;

    const alphaVantageResponse = await alphaVantageApi.get(
      `?function=FX_DAILY&from_symbol=${from_symbol}&to_symbol=${to_symbol}&apikey=${process.env.ALPHA_VANTAGE_API_KAY}`
    )

    response.json(alphaVantageResponse.data['Time Series FX (Daily)'])
  }
}