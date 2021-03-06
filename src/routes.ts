import { Router } from 'express';
import cambioController from './controllers/cambioController';


const routes = Router();

routes.get('/cambio', cambioController.index)

export default routes;