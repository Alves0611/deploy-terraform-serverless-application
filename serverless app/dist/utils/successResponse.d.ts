export declare const successResponse: (message: any, status?: number) => {
    statusCode: number;
    body: string;
    headers: {
        'Content-Type': string;
        'Access-Control-Allow-Origin': string;
        'Access-Control-Allow-Credentials': string;
        'Access-Control-Allow-Methods': string;
        'Access-Control-Allow-Headers': string;
    };
};
