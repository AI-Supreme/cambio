import axios from 'axios';

const alphaVantageApi = axios.create({
  baseURL: 'https://www.alphavantage.co/query'
})

export default alphaVantageApi