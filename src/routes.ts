import { Router } from 'express';
import cambioController from './controllers/cambioController';
import countriesController from './controllers/countriesController';


const routes = Router();

routes.get('/cambio', cambioController.index);

routes.post('/country', countriesController.create);

export default routes;