import { resolve } from 'path';
import fs from 'fs';
import handlebars from 'handlebars';


const sendEmailData = (symbol: string, title: string, description: string) => {
  const emailPath = resolve(__dirname, "..", "..", "views", "emails", "exchangeControllersMail.hbs");
  const templateFileContent = fs.readFileSync(emailPath).toString('utf-8');
  
  const mailTemplateParse = handlebars.compile(templateFileContent);
  const html = mailTemplateParse({ title, currency: symbol, description});
      
  return { 
    from: '"Cambio Moz" <codytech.4@gmail.com>', 
    to: "codytech.4@gmail.com",
    subject: `We had ERROR, getting daily Exchange`,
    text: `
    ${title}
    Currency is ${symbol}.
    You must see what's going wrong.
    ${description}
    `, 
    html: html
  }
}

export default sendEmailData;