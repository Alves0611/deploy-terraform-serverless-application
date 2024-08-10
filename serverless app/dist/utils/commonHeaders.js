"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.headers = void 0;
exports.headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': process.env.CORS_ORIGINS.replaceAll("'", ''),
    'Access-Control-Allow-Credentials': process.env.CORS_CREDS.replaceAll("'", ''),
    'Access-Control-Allow-Methods': process.env.CORS_METHODS.replaceAll("'", ''),
    'Access-Control-Allow-Headers': process.env.CORS_HEADERS.replaceAll("'", ''),
};
//# sourceMappingURL=commonHeaders.js.map