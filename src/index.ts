import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import 'express-async-errors';
import cookieParser from 'cookie-parser';
import errorHandler from './errors/handler';
import { config } from 'dotenv';
import dotenvExpand from 'dotenv-expand';
import cron from 'node-cron';
import routes from './routes';
import dailyExchange from './services/exchangesControllers/dailyExchangeController';
import monthlyExchange from './services/exchangesControllers/monthlyExchangeController';
import weeklyExchange from './services/exchangesControllers/weeklyExchangeController';

dotenvExpand(config());

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

app.use(cookieParser());
app.use('/api/v1', routes);
app.use(errorHandler);

cron.schedule("* * * * *", () => {
  // dailyExchange()
});
cron.schedule("* * * * *", () => {
  // weeklyExchange()
});
cron.schedule("* * * * *", () => {
  // monthlyExchange()
});

app.listen(process.env.HTTP_PORT || 3003);