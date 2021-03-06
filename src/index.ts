import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import 'express-async-errors';
import cookieParser from 'cookie-parser';
import errorHandler from './errors/handler';
import { config } from 'dotenv';
import dotenvExpand from 'dotenv-expand';
import routes from './routes';

dotenvExpand(config());

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

app.use(cookieParser());
app.use('/api/v1', routes);
app.use(errorHandler);

app.listen(process.env.HTTP_PORT || 3003);