import express, { Application } from 'express';
import morgan from 'morgan';

import bodyParser from 'body-parser';
const cors = require('cors')

import AuthUserRoutes from './routes/authuser/authuser.routes';
import GpsProjectRoutes from './routes/gpsproject/gpsproject.routes';
import spProjectRoutes from './routes/spproject/spproject.routes';

const app: Application = express();

// settings
app.set('port', 3000 || process.env.PORT);

// Middlewares
app.use(morgan('dev'));
/*app.use(express.urlencoded({ extended: true }))
app.use(express.json());*/
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())

// Routes
app.use('/api/authuser', AuthUserRoutes);
app.use('/api/gpsproject', GpsProjectRoutes);
app.use('/api/spproject', spProjectRoutes);
//
export default app;