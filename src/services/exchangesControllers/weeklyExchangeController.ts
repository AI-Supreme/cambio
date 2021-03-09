import alphaVantageApi from "../alphaVantageApi";
import sendMail from "../sendMail";
import sendEmailData from "./sendEmailData";


const toSymbols = ['USD', 'ZAR']

const weeklyExchange = async () => {
  toSymbols.forEach(symbol => {
    alphaVantageApi.get(
    `?function=FX_WEEKLY&from_symbol=MZN&to_symbol=${symbol}&apikey=${process.env.ALPHA_VANTAGE_API_KAY}`
    ).then(exchangeRate => {

      console.log(exchangeRate.data['Time Series FX (Weekly)']);
    })
    .catch(err => {
      const time = 'Weekly';
      sendMail(sendEmailData(symbol, time)).catch(mailError => console.log(mailError))
    })
  })
}

export default weeklyExchange;