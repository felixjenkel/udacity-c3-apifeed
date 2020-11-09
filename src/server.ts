import cors from 'cors';
import express from 'express';
import {sequelize} from './sequelize';

import {IndexRouter} from './controllers/v0/index.router';

import bodyParser from 'body-parser';
import {config} from './config/config';
import {V0_FEED_MODELS} from './controllers/v0/model.index';


(async () => {
  await console.log( `server running ${config.url}` );


  console.log(process.env.POSTGRES_USERNAME);
  console.log(process.env.POSTGRES_PASSWORD);
  console.log(process.env.POSTGRES_DB);
  console.log(process.env.POSTGRES_HOST);
  console.log(process.env.AWS_REGION);
  console.log(process.env.AWS_PROFILE);
  console.log(process.env.AWS_BUCKET);
  console.log(process.env.URL);
  console.log(process.env.JWT_SECRET);
  console.log(process.env.PORT);


  try {
    await sequelize.addModels(V0_FEED_MODELS);
  } catch (error) {
    console.log(error);
  }

  try {
    await sequelize.sync();
  } catch (error) {
    console.log(error);
  }


  const app = express();
  const port = process.env.PORT || 8080;

  console.log(port);

  app.use(bodyParser.json());

  app.use(cors({
    allowedHeaders: [
      'Origin', 'X-Requested-With',
      'Content-Type', 'Accept',
      'X-Access-Token', 'Authorization',
    ],
    methods: 'GET,HEAD,OPTIONS,PUT,PATCH,POST,DELETE',
    origin: "*",
  }));

  app.use('/api/v0/', IndexRouter);

  // Root URI call
  app.get( '/', async ( req, res ) => {
    res.send( '/api/v0/' );
  } );

  // Health endpoint
  app.get( '/health', async ( req, res ) => {
    res.sendStatus(200);
    console.log("HealthCheck was running!");
  } );


  // Start the Server
  app.listen( port, () => {
    console.log( `server running ${config.url}` );
    console.log( `press CTRL+C to stop server` );
  } );
})();
