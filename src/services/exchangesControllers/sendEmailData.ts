import { resolve } from 'path';
import fs from 'fs';
import handlebars from 'handlebars';


const sendEmailData = (symbol: string, time: string) => {
  const emailPath = resolve(__dirname, "..", "views", "emails", "exchangeControllersMail.hbs");
  const templateFileContent = fs.readFileSync(emailPath).toString('utf-8');
  
  const mailTemplateParse = handlebars.compile(templateFileContent);
  const html = mailTemplateParse({ time, currency: symbol});
      
  return { 
    from: '"Cambio Moz" <codytech.4@gmail.com>', 
    to: "codytech.4@gmail.com",
    subject: `We had ERROR, getting daily Exchange`,
    text: `
    Error getting ${time} exchange!
    Currency is ${symbol}.
    You must see what's going wrong.
    It looks like we have problem with ALPHA VANTAGE API
    `, 
    html: html
  }
}

export default sendEmailData;