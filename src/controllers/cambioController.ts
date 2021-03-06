import { Request, Response } from "express";
import fs from 'fs';
const { DownloaderHelper } = require('node-downloader-helper');

const fileUrl = 'http://www.bancomoc.mz/Files/REFR/ZMMIREFR.pdf';


export default {
  async index(request: Request, response: Response) {    
    const dl = new DownloaderHelper(fileUrl, __dirname, { fileName: 'codedCambio.pdf' });

    dl.on('end', () => {
      const readStream = fs.createReadStream('./src/controllers/codedCambio.pdf')
      const writeStream = fs.createWriteStream('./src/controllers/cambio.txt', 'utf8')
      
      readStream.on('data', (chunk) => {
        writeStream.write(chunk, (err) => {
          if(err) return console.log(err);
        })
      })

      readStream.pipe(writeStream);
    })
    dl.start();

    response.json('You are going well Boss');
  }
}