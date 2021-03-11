import getCurrencies from "../../entity/country/getList";
import alphaVantageApi from "../alphaVantageApi";
import sendMail from "../sendMail";
import sendEmailData from "./sendEmailData";


const toSymbols = ['USD', 'ZAR']

const weeklyExchange = async () => {
  const currencies = await getCurrencies();
  const toSymbols = currencies.map(currency => currency.iso_4217);
  
  toSymbols.forEach(symbol => {
    alphaVantageApi.get(
    `?function=FX_WEEKLY&from_symbol=MZN&to_symbol=${symbol}&apikey=${process.env.ALPHA_VANTAGE_API_KAY}`
    ).then(exchangeRate => {

      console.log(exchangeRate.data['Time Series FX (Weekly)']);
    })
    .catch(err => {
      const title = 'Error getting Daily exchange!';
      const description = 'It looks like we have problem with ALPHA VANTAGE API'
      sendMail(sendEmailData(symbol, title, description)).catch(mailError => console.log(mailError))
    })
  })
}

export default weeklyExchange;