import { Request, Response } from "express";



export default {
  async index(request: Request, response: Response) {
    response.status(200).json({message: 'You are going well Boss Boa!' });
  }
}