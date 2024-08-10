"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const jwt = __importStar(require("jsonwebtoken"));
const services_1 = require("services");
const utils_1 = require("utils");
const zod_1 = require("zod");
const todoService = new services_1.TodoService(process.env.TABLE_NAME || '');
const verifyToken = (event) => {
    const token = event.headers.Authorization?.split(' ')[1];
    const { payload } = jwt.decode(token, { complete: true });
    return payload;
};
const processRequest = async (userId, event) => {
    const method = event.httpMethod;
    const payload = JSON.parse(event.body);
    const pathParams = event.pathParameters;
    let todo;
    switch (method) {
        case 'DELETE':
            todo = await todoService.delete(userId, pathParams?.todoId);
            break;
        case 'GET':
            const queryString = event.queryStringParameters;
            if (pathParams?.todoId) {
                todo = await todoService.findOne(userId, pathParams?.todoId);
                break;
            }
            todo = await todoService.findMany(userId, queryString?.isDone || '');
            break;
        case 'POST':
            todo = await todoService.create(userId, payload.Task);
            break;
        case 'PUT':
            todo = await todoService.update(userId, payload);
            break;
        default:
            throw new Error(`Unsupported method "${method}"`);
    }
    return todo;
};
const handler = async (event) => {
    if (process.env.DEBUG === 'true') {
        console.log({
            message: 'Event received',
            data: JSON.stringify(event),
        });
    }
    try {
        const payload = verifyToken(event);
        console.log({
            message: 'Decoded token',
            data: JSON.stringify(payload),
        });
        const userId = payload.sub;
        const todo = await processRequest(userId, event);
        console.log({
            message: 'Database response',
            data: JSON.stringify(todo),
        });
        return (0, utils_1.successResponse)(todo, event.httpMethod === 'POST' ? 201 : 200);
    }
    catch (err) {
        if (err instanceof jwt.JsonWebTokenError) {
            console.error({
                message: 'Error while verifying token',
                data: err,
            });
            return (0, utils_1.errorResponse)({ message: 'Unauthorized' }, 401);
        }
        if (err instanceof zod_1.ZodError) {
            console.error({
                message: 'Validation error',
                data: err,
            });
            const message = JSON.parse(err.message);
            return (0, utils_1.errorResponse)({ message: message.map((error) => error.message).join('\n') }, 400);
        }
        console.error({
            message: 'Error while processing event',
            data: err,
        });
        return (0, utils_1.errorResponse)();
    }
};
exports.handler = handler;
//# sourceMappingURL=dynamodb.js.map