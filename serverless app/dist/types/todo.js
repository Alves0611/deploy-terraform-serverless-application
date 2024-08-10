"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TodoItemSchema = void 0;
const zod_1 = require("zod");
exports.TodoItemSchema = zod_1.z.object({
    TodoId: zod_1.z.string().uuid(),
    UserId: zod_1.z.string().uuid(),
    Task: zod_1.z.string().min(5),
    Done: zod_1.z.enum(['1', '0']).default('0').optional(),
    CreatedAt: zod_1.z.string().optional(),
    UpdatedAt: zod_1.z.string().optional(),
});
//# sourceMappingURL=todo.js.map