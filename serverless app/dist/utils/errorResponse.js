"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorResponse = void 0;
const commonHeaders_1 = require("./commonHeaders");
const errorResponse = (message = { message: 'Internal server error' }, status = 500) => ({
    statusCode: status,
    body: JSON.stringify(message),
    headers: commonHeaders_1.headers,
});
exports.errorResponse = errorResponse;
//# sourceMappingURL=errorResponse.js.map