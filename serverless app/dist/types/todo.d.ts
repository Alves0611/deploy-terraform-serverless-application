import { z } from 'zod';
export declare const TodoItemSchema: z.ZodObject<{
    TodoId: z.ZodString;
    UserId: z.ZodString;
    Task: z.ZodString;
    Done: z.ZodOptional<z.ZodDefault<z.ZodEnum<["1", "0"]>>>;
    CreatedAt: z.ZodOptional<z.ZodString>;
    UpdatedAt: z.ZodOptional<z.ZodString>;
}, "strip", z.ZodTypeAny, {
    TodoId?: string;
    UserId?: string;
    Task?: string;
    Done?: "0" | "1";
    CreatedAt?: string;
    UpdatedAt?: string;
}, {
    TodoId?: string;
    UserId?: string;
    Task?: string;
    Done?: "0" | "1";
    CreatedAt?: string;
    UpdatedAt?: string;
}>;
export type TodoItem = z.infer<typeof TodoItemSchema>;
