import alphaVantageApi from "../alphaVantageApi";
import sendMail from "../sendMail";
import sendEmailData from "./sendEmailData";
import saveDailyExchange from "../../entity/exchangeRate/saveDailyExchange";
import getCountries from "../../entity/country/getList";

const dailyExchange = async () => {
  const countries = await getCountries();

  let count = 0;

  countries.forEach(country => {
    setInterval(() => {
      alphaVantageApi.get(
      `?function=FX_DAILY&from_symbol=MZN&to_symbol=${country.iso_4217}&apikey=${process.env.ALPHA_VANTAGE_API_KAY}`
      ).then(exchangeRate => {

        saveDailyExchange(exchangeRate.data['Time Series FX (Daily)'], country.id)
        .catch(err => {
          // const title = 'Error getting Daily exchange!';
          // const description = 'The system could not save Daily exchange.';
          // sendMail(sendEmailData(country.iso_4217, title, description))
          // .catch(mailError => console.log(mailError))

          count++

          console.log('Error ' + count+' to save');
          
        });
      
      }).catch(err => {
        // const title = 'Error getting Daily exchange!';
        // const description = 'It looks like we have problem with ALPHA VANTAGE API'
        // sendMail(sendEmailData(country.iso_4217, title, description))
        // .catch(mailError => console.log(mailError))

        count++

        console.log('Error ' + count+' to getting data');
      })
    }, 13000)
  })
}

export default dailyExchange;