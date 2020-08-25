"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const redis_1 = __importDefault(require("redis"));
const fetch = require('node-fetch');
const crypto = require('crypto');
//const REDIS_PORT = process.env.PORT || 6379;
exports.clientRedis = redis_1.default.createClient();
exports.redisCacheCatalogo = {
    set: (emailUser, dataResp) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            console.log('req.emailUser: ', emailUser);
            let response;
            let repos;
            let data;
            const key = 'cache:' + crypto.createHash('sha256').update(emailUser).digest('hex');
            console.log('set key: ', key);
            console.log('set dataResp: ', dataResp);
            dataResp.map((value, index, array) => {
                console.log('set value: ', value);
                response = value.json();
                data = response;
                //const repos = data.public_repos;
                repos = data.public_repos;
                console.log('set  repos: ', repos);
                exports.clientRedis.setex(key, 3600, repos);
            });
            //await clientRedis.setex(key, 3600, dataResp);
        }
        catch (e) {
            console.log(e);
        }
    }),
    get: (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            console.log('getreq.emailUser: ', req.emailUser);
            const key = 'cache:' + crypto.createHash('sha256').update(req.emailUser).digest('hex');
            let response;
            //const response: any = await clientRedis.get(key);
            yield exports.clientRedis.get(key, (err, dataIn) => {
                if (err)
                    throw err;
                if (dataIn !== null) {
                    console.log('get key: ', key);
                    console.log('get data: ', dataIn);
                    response = dataIn;
                }
                else {
                    next();
                }
            });
            return res.status(200).json({
                message: 'Query succesfully',
                data: response
            });
        }
        catch (e) {
            console.log(e);
            return res.status(500).json({
                message: 'Error in query',
                error: e
            });
        }
    })
};
