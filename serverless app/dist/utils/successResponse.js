"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.successResponse = void 0;
const commonHeaders_1 = require("./commonHeaders");
const successResponse = (message, status = 200) => ({
    statusCode: status,
    body: JSON.stringify(message),
    headers: commonHeaders_1.headers,
});
exports.successResponse = successResponse;
//# sourceMappingURL=successResponse.js.map