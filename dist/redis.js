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
Object.defineProperty(exports, "__esModule", { value: true });
const redis = require('redis');
const fetch = require('node-fetch');
const REDIS_PORT = process.env.REDIS_PORT || 6379;
const clientRedis = redis.createClient(REDIS_PORT);
exports.cache = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { username } = req.params;
        clientRedis.get(username, (err, data) => {
            if (err)
                throw err;
            if (data !== null) {
                res.send(setResponse(username, data));
            }
            else {
                next();
            }
        });
    }
    catch (e) {
        console.log(e);
        return res.status(500).json({
            message: 'Error in query',
            error: e
        });
    }
});
